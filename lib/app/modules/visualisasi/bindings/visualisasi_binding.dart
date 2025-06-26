import 'package:get/get.dart';
import 'package:senja_mobile/app/data/providers/api_provider.dart';
import 'package:senja_mobile/app/data/storage/storage.dart';

import '../controllers/visualisasi_controller.dart';

class VisualisasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisualisasiController>(
      () => VisualisasiController(),
    );
    Get.lazyPut<Storage>(
      () => Storage(),
    );
    Get.lazyPut<ApiProvider>(
      () => ApiProvider(),
    );
  }
}
