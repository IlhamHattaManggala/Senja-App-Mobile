import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class PreviewController extends GetxController {
  late VideoPlayerController videoController;
  final isInitialized = false.obs;
  final isPlaying = false.obs;

  final tariName = ''.obs;
  final previewVideo = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    tariName.value =
        (args['tariName'] ?? '').toLowerCase().replaceAll(' ', '-');
    previewVideo.value = args['previewVideo'] ?? '';

    final assetPath = 'assets/video/${tariName.value}/${previewVideo.value}';

    videoController = VideoPlayerController.asset(assetPath)
      ..initialize().then((_) {
        isInitialized.value = true;
        videoController.play();
        videoController.setLooping(true);
        isPlaying.value = true;

        // Tambahkan listener untuk update status play/pause
        videoController.addListener(() {
          isPlaying.value = videoController.value.isPlaying;
        });
      });
  }

  @override
  void onClose() {
    videoController.dispose();
    super.onClose();
  }
}
