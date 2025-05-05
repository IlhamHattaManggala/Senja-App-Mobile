import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:senja_mobile/app/data/models/user.dart';
import 'package:senja_mobile/app/data/providers/api_provider.dart';

class PengaturanAkunController extends GetxController {
  //TODO: Implement PengaturanAkunController
  final api = Get.find<ApiProvider>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final user = Rxn<User>();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    final argUser = Get.arguments;
    if (argUser != null && argUser is User) {
      setUser(argUser);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void setUser(User data) {
    user.value = data;
    nameController.text = data.name ?? '';
    emailController.text = data.email ?? '';
  }

  Future<void> updateProfile() async {
    try {
      // Validasi sederhana (optional)
      if (nameController.text.isEmpty || emailController.text.isEmpty) {
        Get.snackbar('Error', 'Nama dan email tidak boleh kosong');
        return;
      }

      final response = await api.updateUserProfile({
        'name': nameController.text,
        'email': emailController.text,
        'password':
            passwordController.text.isEmpty ? null : passwordController.text,
      });

      if (response['status'] == 'sukses') {
        Get.snackbar('Sukses', 'Profil berhasil diperbarui');
        // Update user lokal juga
        user.update((val) {
          val?.name = nameController.text;
          val?.email = emailController.text;
        });
      } else {
        Get.snackbar(
            'Gagal', response['message'] ?? 'Gagal memperbarui profil');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    }
  }
}
