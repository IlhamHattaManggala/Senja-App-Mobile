import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';
import 'package:senja_mobile/app/data/landmark/landmark_pointer.dart';

import '../controllers/monitoring_controller.dart';

class MonitoringView extends GetView<MonitoringController> {
  const MonitoringView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PalleteColor.green50,
      appBar: AppBar(
        backgroundColor: PalleteColor.green550,
        title:
            const Text('Tarian', style: TextStyle(color: PalleteColor.green50)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: PalleteColor.green50),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isCameraInitialized.value) {
                return Stack(
                  children: [
                    CameraPreview(controller.cameraController!),
                    Obx(() => CustomPaint(
                          painter: LandmarkPainter(controller.landmarks),
                        )),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
          ),
          Container(
            height: 100,
            color: PalleteColor.green50,
            child: Center(
              child: CircleAvatar(
                radius: 28,
                backgroundColor: PalleteColor.green550,
                child: IconButton(
                  icon:
                      const Icon(Icons.camera_alt, color: PalleteColor.green50),
                  onPressed: () {
                    // TODO: Handle ambil gambar / tracking
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
