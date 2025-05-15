import 'package:get/get.dart';
import 'package:senja_mobile/app/data/models/gerakan_tari.dart';
import 'package:senja_mobile/app/data/models/tari.dart';

class GerakanController extends GetxController {
  late Tari tari;
  final RxList<GerakanTari> gerakanList = <GerakanTari>[].obs;
  final isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    tari = Get.arguments as Tari; // ambil langsung objek Tari dari arguments
    loadGerakan();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void loadGerakan() {
    isLoading.value = true;

    // Misal ambil dari properti langsung
    gerakanList.assignAll(tari.gerakanTari ?? []);
    print(gerakanList);

    // Jika perlu delay loading untuk simulasi atau animasi spinner
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;
    });
  }
}
