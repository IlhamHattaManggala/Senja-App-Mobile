import 'package:get/get.dart';
import 'package:senja_mobile/app/data/providers/api_provider.dart';
import 'package:senja_mobile/app/data/storage/storage.dart';

import '../controllers/berita_controller.dart';

class BeritaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BeritaController>(
      () => BeritaController(),
    );
    Get.lazyPut(() => Storage());
    Get.lazyPut(() => ApiProvider());
  }
}
