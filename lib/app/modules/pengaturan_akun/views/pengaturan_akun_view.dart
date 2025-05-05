import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';
import 'package:senja_mobile/app/widgets/button_custom.dart';
import 'package:senja_mobile/app/widgets/input_field.dart';

import '../controllers/pengaturan_akun_controller.dart';

class PengaturanAkunView extends GetView<PengaturanAkunController> {
  const PengaturanAkunView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PalleteColor.green50,
      appBar: AppBar(
        backgroundColor: PalleteColor.green550,
        title: const Text(
          'Pengaturan Akun',
          style: TextStyle(
            fontSize: 18,
            color: PalleteColor.green50,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                // Nanti tambahkan fungsi untuk pilih foto
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: controller.user.value?.avatar != null
                    ? NetworkImage(controller.user.value?.avatar ?? "")
                    : null,
                child: controller.user.value?.avatar == null
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            InputField(
              hint: controller.user.value?.name ?? "Nama",
              controller: controller.nameController,
              prefixIcon: Icons.person,
              label: "Nama",
            ),
            const SizedBox(height: 16),
            InputField(
              hint: controller.user.value?.email ?? "email@gmail.com",
              controller: controller.emailController,
              prefixIcon: Icons.mail,
              label: "Email",
            ),
            const SizedBox(height: 16),
            InputField(
              hint: "",
              controller: controller.passwordController,
              prefixIcon: Icons.lock,
              label: "Password",
            ),
            const SizedBox(height: 24),
            ButtonCustom(
              name: "Update Profile",
              color: PalleteColor.green550,
              textColor: PalleteColor.green50,
              height: 55,
              onPressed: () {
                controller.updateProfile();
              },
            ),
          ],
        ),
      ),
    );
  }
}
