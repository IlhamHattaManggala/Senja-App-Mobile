import 'package:get/get.dart';
import 'package:senja_mobile/app/data/providers/api_provider.dart';
import 'package:senja_mobile/app/data/storage/storage.dart';

import '../controllers/pengaturan_akun_controller.dart';

class PengaturanAkunBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengaturanAkunController>(
      () => PengaturanAkunController(),
    );
    Get.lazyPut(() => Storage());
    Get.lazyPut(() => ApiProvider());
  }
}
