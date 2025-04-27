import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:senja_mobile/app/config/config_url.dart';

class HistoryController extends GetxController {
  var isLoading = false.obs;
  var allHistoryList = [].obs;
  var filteredHistoryList = [].obs;
  var searchQuery = ''.obs;
  var sortOption = 'Terbaru'.obs; // default urutan
  var sortOptions = [
    'Terbaru',
    'Terlama',
    'Poin Tertinggi',
    'Poin Terendah',
  ].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void fetchHistory() async {
    final box = GetStorage();
    final token = box.read('token');

    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse('$ConfigUrl/api/v1/search'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        allHistoryList.value = data;
        filteredHistoryList.value = data;
        sortHistory();
      } else {
        Get.snackbar("Error", "Gagal mengambil data: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    } finally {
      isLoading(false);
    }
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredHistoryList.value = allHistoryList;
    } else {
      filteredHistoryList.value = allHistoryList.where((item) {
        final title = item['title']?.toLowerCase() ?? '';
        final desc = item['description']?.toLowerCase() ?? '';
        return title.contains(query.toLowerCase()) ||
            desc.contains(query.toLowerCase());
      }).toList();
    }
  }

  void sortHistory() {
    List sortedList = [...filteredHistoryList]; // clone biar ga langsung ubah
    switch (sortOption.value) {
      case 'Terbaru':
        sortedList.sort((a, b) =>
            DateTime.parse(b['date']).compareTo(DateTime.parse(a['date'])));
        break;
      case 'Terlama':
        sortedList.sort((a, b) =>
            DateTime.parse(a['date']).compareTo(DateTime.parse(b['date'])));
        break;
      case 'Poin Tertinggi':
        sortedList.sort((a, b) => (b['point'] ?? 0).compareTo(a['point'] ?? 0));
        break;
      case 'Poin Terendah':
        sortedList.sort((a, b) => (a['point'] ?? 0).compareTo(b['point'] ?? 0));
        break;
    }
    filteredHistoryList.value = sortedList;
  }
}
