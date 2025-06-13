import 'package:get/get.dart';
import 'package:senja_mobile/app/data/models/artikel.dart';
import 'package:senja_mobile/app/data/providers/api_provider.dart';

class BeritaController extends GetxController {
  var artikelList = <Artikel>[].obs;
  var isLoading = false.obs;
  var currentPage = 1;
  var totalPages = 1;
  final api = Get.find<ApiProvider>();

  @override
  void onInit() {
    super.onInit();
    fetchArtikel();
  }

  void fetchArtikel({int page = 1}) async {
    try {
      isLoading(true);
      final result = await api.fetchArtikel(page);
      final List<Artikel> fetchedArticles = result['data'];
      totalPages = result['total_pages'];
      currentPage = result['current_page'];

      if (page == 1) {
        artikelList.assignAll(fetchedArticles);
      } else {
        artikelList.assignAll(
            fetchedArticles); // atau addAll jika ingin infinite scroll
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  void nextPage() {
    if (currentPage < totalPages && !isLoading.value) {
      fetchArtikel(page: currentPage + 1);
    }
  }

  void previousPage() {
    if (currentPage > 1 && !isLoading.value) {
      fetchArtikel(page: currentPage - 1);
    }
  }
}
