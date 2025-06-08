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
          return const Center(
            child: Text(
              'Tidak ada notifikasi.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          );
        }

        return ListView.separated(
          itemCount: data.length,
          padding: const EdgeInsets.all(16),
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final notif = data[index];
            final isUnread = !(notif.isRead ?? true);

            return GestureDetector(
              onTap: () {
                if (isUnread) controller.updateNotif(notif);
                Get.toNamed('/detail-notif', arguments: notif);
              },
              child: Card(
                elevation: 3,
                color: PalleteColor.green50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: isUnread
                      ? const BorderSide(
                          color: PalleteColor.green600, width: 1.5)
                      : BorderSide.none,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.notifications_active_outlined,
                          color: PalleteColor.green600, size: 28),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notif.title,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: PalleteColor.green700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              notif.time != null
                                  ? DateTime.parse(notif.time!)
                                      .toLocal()
                                      .toString()
                                      .split(' ')[0]
                                  : '',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              notif.body,
                              style: const TextStyle(
                                fontSize: 13,
                                color: PalleteColor.green100,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      PopupMenuButton<String>(
                        icon:
                            const Icon(Icons.more_vert, color: Colors.black54),
                        onSelected: (value) {
                          if (value == 'read') {
                            notif.isRead = true;
                            controller.updateNotif(notif);
                          } else if (value == 'delete') {
                            controller.deleteNotif(notif);
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
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
                          const PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete_outline,
                                    color: Colors.red, size: 20),
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
            );
          },
        );
      }),
    );
  }
}
