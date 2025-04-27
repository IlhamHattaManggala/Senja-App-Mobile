import 'package:get/get.dart';
import 'package:senja_mobile/app/data/providers/api_provider.dart';
import 'package:senja_mobile/app/data/storage/storage.dart';

import '../controllers/account_controller.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountController>(
      () => AccountController(),
    );
    Get.lazyPut<ApiProvider>(
      () => ApiProvider(),
    );
    Get.lazyPut<Storage>(
      () => Storage(),
    );
  }
}
