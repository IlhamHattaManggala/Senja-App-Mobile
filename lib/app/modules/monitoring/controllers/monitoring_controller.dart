import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:senja_mobile/app/data/models/gerakan_tari.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart'; // Sesuaikan path

class MonitoringController extends GetxController {
  CameraController? cameraController;
  var isCameraInitialized = false.obs;

  late VideoPlayerController videoController;
  late ChewieController chewieController;
  var isVideoInitialized = false.obs;

  late GerakanTari gerakan;

  @override
  void onInit() {
    super.onInit();
    gerakan = Get.arguments as GerakanTari;
    initializeCamera();
    initializeVideo(gerakan.videoUrl ?? '');
  }

  @override
  void onClose() {
    cameraController?.dispose();
    videoController.dispose();
    chewieController.dispose();
    super.onClose();
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
      );

      await cameraController!.initialize();
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
}
