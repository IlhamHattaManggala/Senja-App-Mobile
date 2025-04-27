import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senja_mobile/app/data/providers/api_provider.dart';

class RegisterController extends GetxController {
  var isChecked = false.obs;
  var isLoading = false.obs;
  var isHiddenPass = true.obs;
  var isHiddenConfirmPass = true.obs;
  final api = Get.find<ApiProvider>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
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
    confirmPasswordController.dispose();
    super.onClose();
  }

  Future<void> handleRegister() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Semua field wajib diisi");
      return;
    }
    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Error', 'Format email tidak valid',
          margin: EdgeInsets.all(10));
      return;
    }

    if (password.length < 8) {
      Get.snackbar('Error', 'Password minimal 6 karakter',
          margin: EdgeInsets.all(10));
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Konfirmasi password tidak cocok',
          margin: EdgeInsets.all(10));
      return;
    }

    isLoading.value = true;

    final success = await api.register(name, email, password);

    isLoading.value = false;

    if (success) {
      Get.snackbar("Berhasil", "Akun berhasil dibuat. Silakan login.");
      Get.offAllNamed('/login');
    } else {
      Get.snackbar("Gagal", "Registrasi gagal. Periksa data Anda.");
    }
  }
}
