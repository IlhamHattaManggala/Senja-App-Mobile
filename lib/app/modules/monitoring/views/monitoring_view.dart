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
      body: Column(
        children: [
          // Baris atas: video di kiri, teks info di kanan
          Container(
            color: PalleteColor.green550,
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Video di kiri
                Obx(() {
                  if (controller.isVideoInitialized.value) {
                    return SizedBox(
                      width: 200,
                      height: 150,
                      child: Chewie(controller: controller.chewieController),
                    );
                  } else {
                    return const SizedBox(width: 200, height: 150);
                  }
                }),

                const SizedBox(width: 16),

                // Teks di kanan
                Expanded(
                  child: Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Prediksi: ${controller.predictedLabel.value}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Akurasi: ${controller.accuracy.value.toStringAsFixed(2)}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            'Presisi: ${controller.precision.value.toStringAsFixed(2)}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            'Skor: ${controller.score.value.toStringAsFixed(2)}%',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Kamera di bawah
          Expanded(
            child: Obx(() {
              if (controller.isCameraInitialized.value &&
                  controller.cameraController != null) {
                return CameraPreview(controller.cameraController!);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
          ),
        ],
      ),
    );
  }
}
