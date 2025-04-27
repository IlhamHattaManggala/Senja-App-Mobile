import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:senja_mobile/app/data/providers/api_provider.dart';

class VerifikasiController extends GetxController {
  //TODO: Implement VerifikasiController
  final pinController = TextEditingController();
  final isLoading = false.obs;
  final api = Get.find<ApiProvider>();
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

  Future<void> kirimVerifikasiPin() async {
    final pin = pinController.text.trim();

    if (pin.length != 6) {
      Get.snackbar("Error", "PIN harus terdiri dari 6 digit");
      return;
    }

    isLoading.value = true;

    try {
      final success = await api.verifikasiPin(pin);
      if (success) {
        Get.snackbar("Berhasil", "PIN berhasil diverifikasi");
        Get.offAllNamed('/reset-password');
      }
    } catch (e) {
      Get.snackbar("Gagal", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
