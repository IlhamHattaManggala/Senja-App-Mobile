import 'dart:async';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:senja_mobile/app/data/providers/api_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class MonitoringController extends GetxController {
  CameraController? cameraController;
  var isCameraInitialized = false.obs;

  late VideoPlayerController videoController;
  late ChewieController chewieController;
  var isVideoInitialized = false.obs;

  final poseDetector = PoseDetector(
    options: PoseDetectorOptions(mode: PoseDetectionMode.stream),
  );

  final List<List<double>> poseSequence = [];
  final int sequenceLength = 30;
  var predictedLabel = ''.obs;
  bool isDetecting = false;

  final score = 0.0.obs;
  int totalPredictions = 0;
  int correctPredictions = 0;
  final accuracy = 0.0.obs;
  final precision = 0.0.obs;
  final predictedConfidence = 0.0.obs;

  late String gerakanName;
  late Interpreter? interpreter;
  List<String> labels = [];
  final List<String> predictedLabelsPerSecond = [];
  int frameCounter = 0;
  final isTraining = false.obs;
  final remainingTime = 60.obs; // 3 menit dalam detik
  Timer? trainingTimer;

  DateTime? latihanStartTime;
  final api = Get.find<ApiProvider>();

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    final tariName = args['tariName'];
    gerakanName = args['gerakanName'];
    final videoUrl = args['gerakanVideoUrl'];
    print(videoUrl);
    poseSequence.clear();
    predictedLabel.value = '';
    totalPredictions = 0;
    correctPredictions = 0;
    score.value = 0.0;
    accuracy.value = 0.0;
    precision.value = 0.0;
    isDetecting = false;
    initializeVideo(videoUrl);
    loadModel(tariName);
  }

  @override
  void onClose() async {
    try {
      await cameraController?.stopImageStream(); // ⬅️ Ini penting!
    } catch (e) {
      print('Gagal stopImageStream: $e');
    }
    cameraController?.dispose();
    videoController.dispose();
    chewieController.dispose();
    interpreter?.close(); // ✅ penting
    trainingTimer?.cancel();
    super.onClose();
  }

  Future<void> loadModel(String tariName) async {
    try {
      String modelPath;
      String labelPath;
      print('🔄 Memuat model untuk tari: $tariName');

      switch (tariName.toLowerCase()) {
        case 'tari topeng endel':
          modelPath = 'assets/models/tari_topeng_endel4.tflite';
          labelPath = 'assets/labels/tari_topeng_endel.txt';
          break;
        case 'tari guci':
          modelPath = 'assets/models/tari_guci3.tflite';
          labelPath = 'assets/labels/tari_guci.txt';
          break;
        case 'tari gambyong mari kangen':
          modelPath = 'assets/models/tari_gambyong3.tflite';
          labelPath = 'assets/labels/tari_gambyong.txt';
          break;
        default:
          throw Exception('Model untuk tari $tariName tidak tersedia');
      }

      interpreter = await Interpreter.fromAsset(modelPath);
      labels = await rootBundle
          .loadString(labelPath)
          .then((value) => value.split('\n'));
      print('Input shape: ${interpreter!.getInputTensor(0).shape}');
      print('Output shape: ${interpreter!.getOutputTensor(0).shape}');

      print('✅ Model "$tariName" berhasil dimuat dari $modelPath');
      print('✅ Labels dimuat: ${labels.length} label');

      await initializeCamera(); // ✅ setelah model
    } catch (e) {
      print('❌ Gagal memuat model untuk $tariName: $e');
    }
  }

  Future<void> initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final backCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
      );

      cameraController = CameraController(
        backCamera,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.nv21,
      );

      await cameraController!.initialize();
      try {
        await cameraController!.startImageStream(processCameraImage);
      } catch (e) {
        print('Gagal startImageStream: $e');
      }
      isCameraInitialized.value = true;
    } catch (e) {
      print('Camera init error: $e');
    }
  }

  Future<void> initializeVideo(String videoUrl) async {
    if (videoUrl.isEmpty) return;
    try {
      videoController = VideoPlayerController.network(videoUrl);
      await videoController.initialize();

      chewieController = ChewieController(
        videoPlayerController: videoController,
        autoPlay: true,
        looping: true,
        aspectRatio: videoController.value.aspectRatio,
      );

      isVideoInitialized.value = true;
    } catch (e) {
      print('Video init error: $e');
    }
  }

  void processCameraImage(CameraImage image) async {
    if (!isTraining.value) return;

    if (cameraController == null || !cameraController!.value.isInitialized) {
      isDetecting = false;
      return;
    }

    if (isDetecting || interpreter == null) return;
    isDetecting = true;

    try {
      final WriteBuffer allBytes = WriteBuffer();
      for (final Plane plane in image.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();

      final rotation = InputImageRotationValue.fromRawValue(
            cameraController!.description.sensorOrientation,
          ) ??
          InputImageRotation.rotation0deg;

      final format = InputImageFormatValue.fromRawValue(image.format.raw);
      if (format == null) {
        print("❌ Format tidak didukung: ${image.format.raw}");
        isDetecting = false;
        return;
      }

      final inputImage = InputImage.fromBytes(
        bytes: bytes,
        metadata: InputImageMetadata(
          size: Size(image.width.toDouble(), image.height.toDouble()),
          rotation: rotation,
          format: format,
          bytesPerRow: image.planes[0].bytesPerRow,
        ),
      );

      final poses = await poseDetector.processImage(inputImage);
      if (poses.isNotEmpty) {
        final List<double> keypoints = [];
        for (var lmType in PoseLandmarkType.values) {
          final lm = poses.first.landmarks[lmType];
          keypoints.addAll(lm != null ? [lm.x, lm.y, lm.z] : [0.0, 0.0, 0.0]);
        }

        if (keypoints.length == 99) {
          final input = [keypoints]; // 👈 bentuknya [1, 99]
          // final input = List.generate(
          //     1, (_) => keypoints.map((v) => [v]).toList()); // [1, 99, 1]

          final outputTensor = interpreter!.getOutputTensor(0);
          final output = List.generate(
            outputTensor.shape[0],
            (_) => List.filled(outputTensor.shape[1], 0.0),
          );

          interpreter!.run(input, output);

          final scores = output[0];
          final maxValue = scores.reduce(max);
          final maxIndex = scores.indexOf(maxValue);
          final confidence = double.parse((maxValue * 100).toStringAsFixed(2));

          final prediction = labels.isNotEmpty && maxIndex < labels.length
              ? labels[maxIndex]
              : 'Gerakan ${maxIndex + 1}';

          predictedConfidence.value = confidence;

          if (labels.length != outputTensor.shape[1]) {
            print(
                "⚠️ Jumlah label (${labels.length}) tidak sesuai jumlah output kelas (${outputTensor.shape[1]})");
          }
          // 👉 Simpan dan evaluasi per detik (seperti sebelumnya)
          predictedLabelsPerSecond.add(prediction);
          frameCounter++;

          if (frameCounter >= 30) {
            final counts = <String, int>{};
            for (var label in predictedLabelsPerSecond) {
              counts[label] = (counts[label] ?? 0) + 1;
            }
            final mostFrequentLabel =
                counts.entries.reduce((a, b) => a.value > b.value ? a : b).key;

            predictedLabel.value = mostFrequentLabel;

            // Hitung skor
            totalPredictions++;
            if (mostFrequentLabel.toLowerCase() == gerakanName.toLowerCase()) {
              correctPredictions++;
            }

            final currentScore = (correctPredictions / totalPredictions) * 100;
            score.value = double.parse(currentScore.toStringAsFixed(2));
            accuracy.value = correctPredictions / totalPredictions;
            final predictedCorrect =
                (mostFrequentLabel.toLowerCase() == gerakanName.toLowerCase())
                    ? 1
                    : 0;
            precision.value = predictedCorrect / totalPredictions;

            predictedLabelsPerSecond.clear();
            frameCounter = 0;
          }
        }
      }
    } catch (e) {
      print("❌ Pose detection error: $e");
    } finally {
      isDetecting = false;
    }
  }

  void startTraining() {
    isTraining.value = true;
    remainingTime.value = 60;
    totalPredictions = 0;
    correctPredictions = 0;
    score.value = 0.0;
    accuracy.value = 0.0;
    precision.value = 0.0;
    predictedLabel.value = '';
    predictedLabelsPerSecond.clear();
    latihanStartTime = DateTime.now();

    trainingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingTime.value--;
      if (remainingTime.value <= 0) {
        timer.cancel();
        isTraining.value = false;
        stopTrainingAndSendResult();
      }
    });
  }

  void stopTrainingAndSendResult() async {
    final averageScore = score.value;

    final success = await api.kirimHasilLatihan(
      tariName: Get.arguments['tariName'],
      gerakanName: gerakanName,
      date: latihanStartTime?.toIso8601String() ??
          DateTime.now().toIso8601String(),
      score: averageScore,
    );

    if (success) {
      // jika ingin tampilkan snackbar atau navigasi
      Get.snackbar("Sukses", "Data latihan telah dikirim ke server.");
    } else {
      Get.snackbar("Gagal", "Gagal mengirim data ke server.");
    }
  }
}
