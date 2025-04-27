import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:senja_mobile/app/data/providers/api_provider.dart';

class LoginController extends GetxController {
  var isChecked = false.obs;
  var isLoading = false.obs;
  var isHiddenPass = true.obs;
  final box = GetStorage();
  final api = Get.find<ApiProvider>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email dan password tidak boleh kosong");
      return;
    }

    isLoading.value = true;

    final user = await api.login(email, password);
    isLoading.value = false;

    if (user != null) {
      // Navigasi berdasarkan role
      if (user.role == 'admin') {
        Get.offAllNamed('/admin'); // ganti sesuai route-mu
      } else {
        Get.offAllNamed('/navbar'); // ganti sesuai route-mu
      }

      Get.snackbar("Login Berhasil", "Selamat datang, ${user.name}");
    } else {
      Get.snackbar("Login Gagal", "Email atau password salah");
    }
  }
}
