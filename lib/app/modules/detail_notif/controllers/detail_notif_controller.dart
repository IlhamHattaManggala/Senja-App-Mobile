import 'package:get/get.dart';
import 'package:senja_mobile/app/data/models/notifikasi.dart';

class DetailNotifController extends GetxController {
  late Notifikasi notif;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    notif = Get.arguments as Notifikasi;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
