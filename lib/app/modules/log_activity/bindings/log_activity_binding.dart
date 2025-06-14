import 'package:get/get.dart';
import 'package:senja_mobile/app/data/providers/api_provider.dart';
import 'package:senja_mobile/app/data/storage/storage.dart';

import '../controllers/log_activity_controller.dart';

class LogActivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogActivityController>(
      () => LogActivityController(),
    );
    Get.lazyPut<ApiProvider>(
      () => ApiProvider(),
    );
    Get.lazyPut<Storage>(
      () => Storage(),
    );
  }
}
