import 'package:get/get.dart';
import 'package:senja_mobile/app/data/cache/video_cache_manager.dart';
import 'package:senja_mobile/app/data/models/seni_lainnya.dart';
import 'package:senja_mobile/app/data/models/tari.dart';
import 'package:senja_mobile/app/data/providers/api_provider.dart';
import 'package:senja_mobile/app/data/storage/storage.dart';

class HomeController extends GetxController {
  var selectedLevel = "Semua Level".obs;
  final api = Get.find<ApiProvider>();
  final storage = Get.find<Storage>();
  final isLoading = false.obs;
  // Data dari API
  var tariList = <Tari>[].obs;
  var seniLainnyaList = <SeniLainnya>[].obs;
  var videoCacheMap = <String, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    // seniLainnyaList.assignAll(dummySeniLainnya);
    // tariList.assignAll(dummyTariList);
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
      for (var tari in tariList) {
        for (var gerakan in tari.gerakanTari!) {
          final videoUrl = gerakan.videoUrl ?? '';
          if (videoUrl.isNotEmpty) {
            final file = await VideoCacheManager().getSingleFile(videoUrl);
            print("✅ Downloaded: ${file.path}");
            videoCacheMap[videoUrl] = file.path;
          }
        }
      }
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
}
