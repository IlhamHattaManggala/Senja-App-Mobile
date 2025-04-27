import 'package:get/get.dart';
import 'package:senja_mobile/app/data/providers/api_provider.dart';
import 'package:senja_mobile/app/data/storage/storage.dart';

import '../controllers/notifikasi_controller.dart';

class NotifikasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotifikasiController>(
      () => NotifikasiController(),
    );
    Get.lazyPut<ApiProvider>(
      () => ApiProvider(),
    );
    Get.lazyPut<Storage>(
      () => Storage(),
    );
  }
}
