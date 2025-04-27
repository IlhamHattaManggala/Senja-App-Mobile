import 'package:get/get.dart';
import 'package:senja_mobile/app/data/models/gerakan_tari.dart';
import 'package:senja_mobile/app/data/models/tari.dart';

class GerakanController extends GetxController {
  //TODO: Implement GerakanController
  late Tari tari;
  final RxList<GerakanTari> gerakanList = <GerakanTari>[].obs;
  final isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    final data = Get.arguments as Map<String, dynamic>;
    tari = Tari.fromJson(data); // <-- Ini penting!
    gerakanList.assignAll(tari.gerakanTari ?? []);
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
