import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:senja_mobile/app/data/models/user.dart';
import 'package:senja_mobile/app/data/providers/api_provider.dart';

class LoginController extends GetxController {
  var isChecked = false.obs;
  var isLoading = false.obs;
  var isLoadingGoogle = false.obs;
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
    String? expiredAtStr = box.read('tokenExpiredAt');

    debugPrint("AUTO LOGIN DATA: $userData");

    if (isLoggedIn == true && userData != null && expiredAtStr != null) {
      DateTime expiredAt = DateTime.parse(expiredAtStr);
      if (DateTime.now().isBefore(expiredAt)) {
        try {
          final user = User.fromJson(Map<String, dynamic>.from(userData));
          debugPrint("Parsed User: ${user.toJson()}");

          if (user.role == 'admin') {
            Get.offAllNamed('/admin');
          } else {
            Get.offAllNamed('/navbar');
          }
        } catch (e) {
          debugPrint("Gagal parsing user: $e");
          // Kalau parsing gagal, arahkan ke login
          box.remove('isLoggedIn');
          box.remove('user');
          box.remove('token');
          box.remove('tokenExpiredAt');
          Get.offAllNamed('/login');
          Get.snackbar("Login Gagal", "Silahkan login kembali");
        }
      } else {
        // Token expired
        box.remove('isLoggedIn');
        box.remove('user');
        box.remove('token');
        box.remove('tokenExpiredAt');
        Get.offAllNamed('/login'); // Redirect ke halaman login
        Get.snackbar("Login Gagal", "Token expired, Silahkan login kembali!");
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

    try {
      final user = await api.login(email, password);
      isLoading.value = false;

      if (user != null) {
        if (isChecked.value) {
          box.write('isLoggedIn', true);
          box.write('user', user.toJson());
          box.write(
            'tokenExpiredAt',
            DateTime.now().add(Duration(hours: 24)).toIso8601String(),
          );
        }

        // Navigasi berdasarkan role
        Get.offAllNamed('/navbar');
        Get.snackbar("Login Berhasil", "Selamat datang, ${user.name}");
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Login Gagal", e.toString().replaceAll('Exception: ', ''));
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      isLoadingGoogle.value = true;

      final user = await api.loginGoogle();
      isLoadingGoogle.value = false;
      debugPrint("User.toJson: ${user?.toJson()}");

      if (user != null) {
        if (isChecked.value) {
          box.write('isLoggedIn', true);
          box.write('user', user.toJson()); // ✅ pastikan pakai `toJson()`
          box.write(
            'tokenExpiredAt',
            DateTime.now().add(Duration(hours: 24)).toIso8601String(),
          );
        }

        // Navigasi berdasarkan role
        if (user.role == 'admin') {
          Get.offAllNamed('/navbar');
        } else {
          Get.offAllNamed('/navbar');
        }

        Get.snackbar("Login Berhasil", "Selamat datang, ${user.name}");
      } else {
        Get.snackbar("Login Gagal", "Login Google gagal.");
      }
    } catch (e) {
      isLoadingGoogle.value = false;
      Get.snackbar("Error", "Terjadi kesalahan saat login Google");
      print("Login Google error: $e");
    }
  }
}
