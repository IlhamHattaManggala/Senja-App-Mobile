import 'package:get/get.dart';
import 'package:senja_mobile/app/data/providers/api_provider.dart';
import 'package:senja_mobile/app/data/storage/storage.dart';

import '../controllers/verifikasi_controller.dart';

class VerifikasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifikasiController>(
      () => VerifikasiController(),
    );
    Get.lazyPut<ApiProvider>(
      () => ApiProvider(),
    );
    Get.lazyPut<Storage>(
      () => Storage(),
    );
  }
}
