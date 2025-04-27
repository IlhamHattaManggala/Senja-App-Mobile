import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';

import '../controllers/bantuan_controller.dart';

class BantuanView extends GetView<BantuanController> {
  const BantuanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PalleteColor.green550,
        title: const Text(
          'Pusat Bantuan',
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
              'Butuh Bantuan?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: PalleteColor.green700,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Berikut beberapa pertanyaan yang sering ditanyakan dan panduan umum untuk menggunakan aplikasi SENJA:',
              style: TextStyle(
                fontSize: 16,
                color: PalleteColor.green600,
              ),
            ),
            SizedBox(height: 20),
            _FaqItem(
              question: 'Bagaimana cara memulai monitoring gerakan tari?',
              answer:
                  'Buka halaman utama, pilih menu "Monitoring", lalu ikuti petunjuk untuk mulai merekam gerakan.',
            ),
            _FaqItem(
              question: 'Apa saja yang bisa saya pelajari di aplikasi ini?',
              answer:
                  'Kamu bisa mempelajari berbagai alat musik tradisional Jawa, jenis-jenis tari, dan sejarah seni budaya Jawa.',
            ),
            _FaqItem(
              question: 'Apakah aplikasi ini membutuhkan koneksi internet?',
              answer:
                  'Sebagian besar konten bisa diakses offline, tapi fitur pembaruan data dan video memerlukan koneksi internet.',
            ),
          ],
        ),
      ),
    );
  }
}

class _FaqItem extends StatelessWidget {
  final String question;
  final String answer;

  const _FaqItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: PalleteColor.green700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            answer,
            style: const TextStyle(
              fontSize: 14,
              color: PalleteColor.green600,
            ),
          ),
        ],
      ),
    );
  }
}
