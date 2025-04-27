import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';
import '../controllers/notifikasi_controller.dart';

class NotifikasiView extends GetView<NotifikasiController> {
  const NotifikasiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PalleteColor.green50,
      appBar: AppBar(
        backgroundColor: PalleteColor.green550,
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: PalleteColor.green50,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = controller.notif;
        if (data.isEmpty) {
          return Center(child: Text('Tidak ada notifikasi.'));
        }

        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final notif = data[index];
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  if (!notif.isRead!) {
                    controller.updateNotif(notif);
                  }
                  Get.toNamed('/detail-notif', arguments: notif);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    color: PalleteColor.green50,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: notif.isRead!
                          ? BorderSide.none
                          : const BorderSide(
                              color: PalleteColor.green600, width: 1.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  notif.title,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: PalleteColor.green700,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  notif.time != null
                                      ? DateTime.parse(notif.time!)
                                          .toLocal()
                                          .toString()
                                          .split(' ')[0]
                                      : '',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: PalleteColor.green700,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  notif.body,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: PalleteColor.green100,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuButton<String>(
                            color: PalleteColor.green50,
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.more_horiz,
                                size: 20, color: PalleteColor.green700),
                            onSelected: (value) {
                              if (value == 'read') {
                                // Tandai sebagai dibaca
                                notif.isRead = true;
                                controller.updateNotif(notif);
                              } else if (value == 'delete') {
                                // Hapus notifikasi
                                controller.deleteNotif(notif);
                              }
                            },
                            itemBuilder: (context) => const [
                              PopupMenuItem(
                                value: 'read',
                                child: Row(
                                  children: [
                                    Icon(Icons.mark_email_read_outlined,
                                        color: PalleteColor.green550, size: 20),
                                    SizedBox(width: 8),
                                    Text('Tandai dibaca'),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Icon(Icons.delete_outline,
                                        color: PalleteColor.green600, size: 20),
                                    SizedBox(width: 8),
                                    Text('Hapus'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
