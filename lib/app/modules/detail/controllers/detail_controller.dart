import 'package:get/get.dart';
import 'package:senja_mobile/app/data/models/seni_lainnya.dart';

class DetailController extends GetxController {
  late SeniLainnya seniItem;
  List get detailList => seniItem.details ?? [];
  @override
  void onInit() {
    super.onInit();
    seniItem = SeniLainnya.fromJson(Get.arguments);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
