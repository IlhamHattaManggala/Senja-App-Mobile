import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';
import '../controllers/log_activity_controller.dart';

class LogActivityView extends GetView<LogActivityController> {
  const LogActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PalleteColor.green50,
      appBar: AppBar(
        title:
            const Text('Log Aktivitas', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: PalleteColor.green550,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        if (controller.logList.isEmpty) {
          return const Center(child: Text('Tidak ada log aktivitas'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.logList.length,
          itemBuilder: (context, index) {
            final item = controller.logList[index];
            return Card(
              color: PalleteColor.green50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person, color: PalleteColor.green550),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item.email ?? 'Tanpa email',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.aktivitas ?? 'Aktivitas tidak tersedia',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          controller.formatDateOnly(item.waktu ?? ''),
                          style:
                              const TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        const SizedBox(width: 16),
                        const Icon(Icons.access_time,
                            size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          controller.formatTimeOnly(item.waktu ?? ''),
                          style:
                              const TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
