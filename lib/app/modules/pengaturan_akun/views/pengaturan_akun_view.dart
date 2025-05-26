import 'dart:io';

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            controller.refresh();
            Get.back(); // atau Navigator.pop(context)
          },
        ),
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
                controller.pickImage();
              },
              child: Obx(() {
                final avatarUrl = controller.user.value?.avatar;
                final localImage = controller.pickedImage;

                return CircleAvatar(
                  radius: 50,
                  backgroundImage: localImage != null
                      ? FileImage(File(localImage.path))
                      : (avatarUrl != null
                          ? NetworkImage(avatarUrl) as ImageProvider
                          : null),
                  child: localImage == null && avatarUrl == null
                      ? const Icon(Icons.person, size: 50)
                      : null,
                );
              }),
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
