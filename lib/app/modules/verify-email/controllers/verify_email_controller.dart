import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:senja_mobile/app/data/providers/api_provider.dart';
import 'package:senja_mobile/app/data/storage/storage.dart';

class VerifyEmailController extends GetxController {
  final pinEmailController = TextEditingController();
  final isLoading = false.obs;
  final api = Get.find<ApiProvider>();
  final box = Get.find<Storage>();
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
    super.onClose();
  }

  Future<void> kirimVerifyEmail() async {
    final pin = pinEmailController.text.trim();

    if (pin.length != 6) {
      Get.snackbar("Error", "PIN harus terdiri dari 6 digit");
      return;
    }

    isLoading.value = true;
    try {
      final success = await api.verifyEmail(pin);
      if (success) {
        Get.snackbar("Berhasil", "Akun berhasil terverifikasi");
        pinEmailController.clear();
        Get.offAllNamed('/login');
      }
    } catch (e) {
      Get.snackbar("Gagal", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
