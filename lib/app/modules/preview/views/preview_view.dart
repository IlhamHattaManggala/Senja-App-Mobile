import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';
import 'package:video_player/video_player.dart';

import '../controllers/preview_controller.dart';

class PreviewView extends GetView<PreviewController> {
  const PreviewView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PalleteColor.green50,
      appBar: AppBar(
        backgroundColor: PalleteColor.green550,
        title: const Text('Preview Video',
            style: TextStyle(color: PalleteColor.green50)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: PalleteColor.green50),
          onPressed: () => Get.back(),
        ),
      ),
      body: Center(
        child: Obx(() {
          if (!controller.isInitialized.value) {
            return const CircularProgressIndicator();
          }

          return AspectRatio(
            aspectRatio: controller.videoController.value.aspectRatio,
            child: VideoPlayer(controller.videoController),
          );
        }),
      ),
      floatingActionButton: Obx(() => controller.isInitialized.value
          ? FloatingActionButton(
              onPressed: () {
                if (controller.isPlaying.value) {
                  controller.videoController.pause();
                } else {
                  controller.videoController.play();
                }
              },
              child: Obx(() => Icon(
                    controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                  )),
            )
          : const SizedBox.shrink()),
    );
  }
}
