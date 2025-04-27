import 'package:get/get.dart';

class SplashscreenController extends GetxController {
  var showButton = false.obs;
  @override
  void onInit() {
    nextOverview();
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

  void nextOverview() async {
    await Future.delayed(const Duration(seconds: 5));
    showButton.value = true;
  }
}
