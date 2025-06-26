import 'package:get/get.dart';
import 'package:senja_mobile/app/config/config_url.dart';
import 'package:senja_mobile/app/data/models/seni_lainnya.dart';
import 'package:senja_mobile/app/data/models/tari.dart';
import 'package:senja_mobile/app/data/providers/api_provider.dart';
import 'package:senja_mobile/app/data/storage/storage.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  var selectedLevel = "Semua Level".obs;
  final api = Get.find<ApiProvider>();
  final storage = Get.find<Storage>();
  final isLoading = false.obs;
  // Data dari API
  var tariList = <Tari>[].obs;
  var seniLainnyaList = <SeniLainnya>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBerandaData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void fetchBerandaData() async {
    try {
      isLoading(true);
      final result = await api.fetchBeranda();
      tariList.value = result['tari'];
      seniLainnyaList.value = result['seni_lainnya'];
    } catch (e) {
      print('Error saat fetch beranda: $e');
    } finally {
      isLoading(false);
    }
  }

  List<Tari> get filteredTari {
    if (selectedLevel.value == "Semua Level") return tariList;
    return tariList.where((tari) => tari.level == selectedLevel.value).toList();
  }

  void updateLevel(String level) {
    selectedLevel.value = level;
  }

  void goToWeb() async {
    final url = Uri.parse(ConfigUrl.StreamlitUrl);
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      Get.snackbar("Gagal", "Tidak dapat membuka link: $e");
    }
  }
}
