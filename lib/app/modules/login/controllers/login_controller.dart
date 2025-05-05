import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:senja_mobile/app/data/models/user.dart';
import 'package:senja_mobile/app/data/providers/api_provider.dart';

class LoginController extends GetxController {
  var isChecked = false.obs;
  var isLoading = false.obs;
  var isHiddenPass = true.obs;
  final box = GetStorage();
  final api = Get.find<ApiProvider>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final storageKey = 'rememberMe';

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _autoLoginIfRemembered();
    });
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

  void _autoLoginIfRemembered() {
    bool? isLoggedIn = box.read('isLoggedIn');
    var userData = box.read('user');

    if (isLoggedIn == true && userData != null) {
      final user = User.fromJson(userData);
      if (user.role == 'admin') {
        Get.offAllNamed('/admin');
      } else {
        Get.offAllNamed('/navbar');
      }
    }
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
      if (isChecked.value) {
        box.write('isLoggedIn', true);
        box.write('user', user.toJson()); // pastikan model User punya toJson()
      }
      // Navigasi berdasarkan role
      if (user.role == 'admin') {
        Get.offAllNamed('/navbar'); // ganti sesuai route-mu
      } else {
        Get.offAllNamed('/navbar'); // ganti sesuai route-mu
      }

      Get.snackbar("Login Berhasil", "Selamat datang, ${user.name}");
    } else {
      Get.snackbar("Login Gagal", "Email atau password salah");
    }
  }
}
