import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pengaturan_akun_controller.dart';

class PengaturanAkunView extends GetView<PengaturanAkunController> {
  const PengaturanAkunView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PengaturanAkunView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PengaturanAkunView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
