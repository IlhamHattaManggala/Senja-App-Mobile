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
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Video dan Info Prediksi
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              color: PalleteColor.green550,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Video
                    Obx(() {
                      if (controller.isVideoInitialized.value) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            width: 200,
                            height: 150,
                            child:
                                Chewie(controller: controller.chewieController),
                          ),
                        );
                      } else {
                        return Container(
                          width: 200,
                          height: 150,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(
                              color: Colors.white),
                        );
                      }
                    }),
                    const SizedBox(width: 16),

                    // Info Prediksi
                    Expanded(
                      child: Obx(() => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              infoItem(
                                  "Prediksi", controller.predictedLabel.value),
                              infoItem("Akurasi",
                                  controller.accuracy.value.toStringAsFixed(2)),
                              infoItem("Confidence",
                                  "${controller.predictedConfidence.value.toStringAsFixed(2)}%"),
                              infoItem("Skor",
                                  "${controller.score.value.toStringAsFixed(2)}%"),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Tombol atau Timer
            Obx(() {
              if (!controller.isTraining.value) {
                return ElevatedButton.icon(
                  onPressed: controller.startTraining,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Mulai Latihan',
                      style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PalleteColor.green550,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 3,
                  ),
                );
              } else {
                final minutes = (controller.remainingTime.value ~/ 60)
                    .toString()
                    .padLeft(2, '0');
                final seconds = (controller.remainingTime.value % 60)
                    .toString()
                    .padLeft(2, '0');
                return Text(
                  'Waktu tersisa: $minutes:$seconds',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                );
              }
            }),

            const SizedBox(height: 12),

            // Preview Kamera
            Expanded(
              child: Obx(() {
                if (controller.isCameraInitialized.value &&
                    controller.cameraController != null) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CameraPreview(controller.cameraController!),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

// Fungsi widget untuk info prediksi
  Widget infoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text('$label: ',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          Expanded(
            child: Text(value,
                style: const TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
