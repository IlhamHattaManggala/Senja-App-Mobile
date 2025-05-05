import 'package:camera/camera.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';
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
      body: Stack(
        children: [
          Obx(() {
            if (controller.isCameraInitialized.value &&
                controller.cameraController != null) {
              return Positioned.fill(
                child: CameraPreview(controller.cameraController!),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
          Positioned(
            top: 20,
            right: 20,
            child: Obx(() {
              if (controller.isVideoInitialized.value) {
                return SizedBox(
                  width: 200, // sesuaikan ukuran
                  height: 150,
                  child: Chewie(controller: controller.chewieController),
                );
              } else {
                return const SizedBox(); // atau loading spinner
              }
            }),
          ),
          // Tambahkan teks untuk akurasi, presisi, dan skor di kiri bawah
          Positioned(
            bottom: 20, // Posisi dari bawah
            left: 20, // Posisi dari kiri
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Akurasi: ', // Contoh nilai akurasi
                    style: TextStyle(color: PalleteColor.green50, fontSize: 16),
                  ),
                  Text(
                    'Presisi: ', // Contoh nilai presisi
                    style: TextStyle(color: PalleteColor.green50, fontSize: 16),
                  ),
                  Text(
                    'Skor: ', // Contoh nilai skor
                    style: TextStyle(color: PalleteColor.green50, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
