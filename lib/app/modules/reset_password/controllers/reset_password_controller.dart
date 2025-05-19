import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:senja_mobile/app/data/providers/api_provider.dart';

class ResetPasswordController extends GetxController {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isHiddenPassword = true.obs;
  final isHiddenConfirm = true.obs;
  final isLoading = false.obs;
  final api = Get.find<ApiProvider>();
  late String pin;
  @override
  void onInit() {
    super.onInit();
    pin = Get.arguments['pin'];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  Future<void> kirimPermintaanReset() async {
    final password = passwordController.text;
    if (password.isEmpty) {
      Get.snackbar("Error", "Password tidak boleh kosong");
      return;
    }
    if (password.length < 6) {
      Get.snackbar("Error", "Password minimal 6 karakter");
      return;
    }
    if (password != confirmPasswordController.text) {
      Get.snackbar("Error", "Password tidak sama");
      return;
    }

    isLoading.value = true;

    try {
      final success = await api.resetPassword(pin, password);
      if (success) {
        Get.snackbar("Berhasil", "Password berhasil diubah");
        passwordController.clear();
        confirmPasswordController.clear();
        Get.toNamed('/login');
      }
    } catch (e) {
      Get.snackbar("Gagal", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
