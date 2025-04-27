import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';

import '../controllers/tentang_controller.dart';

class TentangView extends GetView<TentangController> {
  const TentangView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PalleteColor.green550,
        title: const Text(
          'Tentang Aplikasi',
          style: TextStyle(color: PalleteColor.green50),
        ),
        iconTheme: const IconThemeData(color: PalleteColor.green50),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        color: PalleteColor.green50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'SENJA APP',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: PalleteColor.green700,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'SENJA (Seni Jawa) App adalah aplikasi monitoring gerakan tari serta media edukasi seputar seni budaya Jawa. '
              'Aplikasi ini dirancang untuk membantu masyarakat, pelajar, dan penggiat seni dalam memahami serta '
              'melestarikan kekayaan budaya Jawa, terutama dalam seni tari dan alat musik tradisional.',
              style: TextStyle(
                fontSize: 16,
                color: PalleteColor.green600,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Versi Aplikasi: 1.0.0',
              style: TextStyle(fontSize: 14, color: PalleteColor.green700),
            ),
            SizedBox(height: 4),
            Text(
              'Dikembangkan oleh: Tim SENJA Dev',
              style: TextStyle(fontSize: 14, color: PalleteColor.green700),
            ),
          ],
        ),
      ),
    );
  }
}
