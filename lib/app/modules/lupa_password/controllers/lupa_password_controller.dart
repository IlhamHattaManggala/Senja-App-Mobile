import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:senja_mobile/app/data/providers/api_provider.dart';

class LupaPasswordController extends GetxController {
  final api = Get.find<ApiProvider>();
  final emailController = TextEditingController();
  final isLoading = false.obs;

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
    super.onClose();
  }

  Future<void> kirimPermintaanReset() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      Get.snackbar("Error", "Email tidak boleh kosong");
      return;
    }

    isLoading.value = true;

    try {
      final success = await api.lupaPassword(email);
      if (success) {
        Get.snackbar(
            "Berhasil", "Link reset kata sandi telah dikirim ke email kamu");
        emailController.clear();
        Get.toNamed('/verifikasi');
      }
    } catch (e) {
      Get.snackbar("Gagal", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
