import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';

import '../controllers/detail_notif_controller.dart';

class DetailNotifView extends GetView<DetailNotifController> {
  const DetailNotifView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PalleteColor.green550,
        title: const Text(
          'Detail Notifikasi',
          style: TextStyle(
            fontSize: 18,
            color: PalleteColor.green50,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: PalleteColor.green50,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: PalleteColor.green100,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.notif.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: PalleteColor.green800,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  controller.notif.time?.split('T')[0] ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: PalleteColor.green700,
                  ),
                ),
                const Divider(height: 24, thickness: 1),
                Text(
                  controller.notif.body,
                  style: const TextStyle(
                    fontSize: 16,
                    color: PalleteColor.green900,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
