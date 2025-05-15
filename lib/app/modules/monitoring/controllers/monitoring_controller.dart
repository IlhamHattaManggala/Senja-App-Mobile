import 'dart:io';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:senja_mobile/app/modules/home/controllers/home_controller.dart';
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

  late String gerakanName;
  late Interpreter? interpreter;
  List<String> labels = [];

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    final tariName = args['tariName'];
    gerakanName = args['gerakanName'];
    final videoUrl = args['gerakanVideoUrl'];
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
  void onClose() {
    cameraController?.dispose();
    videoController.dispose();
    chewieController.dispose();
    interpreter?.close(); // ✅ penting
    super.onClose();
  }

  Future<void> loadModel(String tariName) async {
    try {
      String modelPath;
      String labelPath;

      switch (tariName.toLowerCase()) {
        case 'tari topeng endel':
          modelPath = 'assets/models/tari_topeng_endel.tflite';
          labelPath = 'assets/labels/tari_topeng_endel.txt';
          break;
        case 'tari guci':
          modelPath = 'assets/models/tari_guci.tflite';
          labelPath = 'assets/labels/tari_guci.txt';
          break;
        case 'tari gambyong':
          modelPath = 'assets/models/tari_gambyong.tflite';
          labelPath = 'assets/labels/tari_gambyong.txt';
          break;
        default:
          throw Exception('Model untuk tari $tariName tidak tersedia');
      }

      interpreter = await Interpreter.fromAsset(modelPath);
      labels = await rootBundle
          .loadString(labelPath)
          .then((value) => value.split('\n'));

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
      await cameraController!.startImageStream(processCameraImage);
      isCameraInitialized.value = true;
    } catch (e) {
      print('Camera init error: $e');
    }
  }

  Future<void> initializeVideo(String videoUrl) async {
    if (videoUrl.isEmpty) return;
    try {
      final homeController = Get.find<HomeController>();
      final cachedPath = homeController.videoCacheMap[videoUrl];

      if (cachedPath != null) {
        videoController = VideoPlayerController.file(File(cachedPath));
      } else {
        videoController = VideoPlayerController.network(videoUrl);
      }
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
          poseSequence.add(keypoints);
          if (poseSequence.length > sequenceLength) {
            poseSequence.removeAt(0);
          }

          if (poseSequence.length == sequenceLength) {
            final input = [poseSequence];
            final outputTensor = interpreter!.getOutputTensor(0);
            final output = List.generate(
              outputTensor.shape[0],
              (_) => List.filled(outputTensor.shape[1], 0.0),
            );

            interpreter!.run(input, output);
            final maxIndex =
                output[0].indexWhere((e) => e == output[0].reduce(max));
            final prediction = labels.isNotEmpty && maxIndex < labels.length
                ? labels[maxIndex]
                : 'Gerakan ${maxIndex + 1}';
            predictedLabel.value = prediction;

            totalPredictions++;
            if (prediction.toLowerCase() == gerakanName.toLowerCase()) {
              correctPredictions++;
            }

            final currentScore = (correctPredictions / totalPredictions) * 100;
            score.value = double.parse(currentScore.toStringAsFixed(2));

            accuracy.value = correctPredictions / totalPredictions;
            final predictedCorrect =
                (prediction.toLowerCase() == gerakanName.toLowerCase()) ? 1 : 0;
            precision.value = predictedCorrect / totalPredictions;
          }
        }
      }
    } catch (e) {
      print("❌ Pose detection error: $e");
    } finally {
      isDetecting = false;
    }
  }
}
