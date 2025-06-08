import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senja_mobile/app/data/providers/api_provider.dart';
import 'package:senja_mobile/app/data/storage/storage.dart';

class LaporanController extends GetxController {
  // Observable variables
  final tariName = 'Default'.obs;
  final historiData = <Map<String, dynamic>>[].obs;
  final scoreData = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;
  final storage = Get.find<Storage>();
  final api = Get.find<ApiProvider>();
  final selectedChartType = 'bar'.obs;
  final riwayatList = <Map<String, dynamic>>[].obs;

  final currentPage = 1.obs;
  final itemsPerPage = 5.obs;

  int get totalPages => (historiData.length / itemsPerPage.value).ceil();

  List<Map<String, dynamic>> get paginatedData {
    final start = (currentPage.value - 1) * itemsPerPage.value;
    final end = start + itemsPerPage.value;
    return historiData.sublist(
      start,
      end > historiData.length ? historiData.length : end,
    );
  }

  @override
  void onInit() {
    super.onInit();
    // Get arguments if available, otherwise use defaults
    final args = Get.arguments;
    if (args != null) {
      if (args['tariName'] != null) {
        tariName.value = args['tariName'];
      }
    }
    fetchRiwayat();
  }

  String formatTanggal(String tanggal) {
    final dateTime = DateTime.parse(tanggal);
    final bulanIndo = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];

    final hari = dateTime.day.toString().padLeft(2, '0');
    final bulan = bulanIndo[dateTime.month - 1];
    final tahun = dateTime.year;

    final jam = dateTime.hour.toString().padLeft(2, '0');
    final menit = dateTime.minute.toString().padLeft(2, '0');

    return '$hari $bulan $tahun, $jam:$menit';
  }

  void exportData() {
    if (scoreData.isEmpty) {
      Get.snackbar(
        'Info',
        'Tidak ada data untuk diekspor',
        backgroundColor: Colors.amber,
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      // Your existing export code
      Get.snackbar(
        'Info',
        'Data berhasil diekspor',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Method to get score for specific day for chart
  double getScoreForDay(int dayIndex) {
    try {
      if (scoreData.isNotEmpty && dayIndex < scoreData.length) {
        return scoreData[dayIndex]['score'].toDouble();
      }
    } catch (e) {
      print('Error getting score for day $dayIndex: $e');
    }
    return 0.0; // Default value if data not available
  }

  void fetchRiwayat() async {
    try {
      isLoading(true);
      final result = await api.fetchRiwayat();
      debugPrint(result.toString());

      // Simpan semua data
      riwayatList.assignAll(result!);
      if (result.isEmpty) {
        debugPrint('❌ Tidak ada data riwayat untuk ${tariName.value}');
        return;
      }

      // Filter berdasarkan tariName
      final filtered =
          result.where((e) => e['tari_name'] == tariName.value).map((e) {
        return {
          ...e,
          'date': formatTanggal(e['date']), // ubah format tanggal
        };
      }).toList();
      historiData.assignAll(filtered);
      scoreData.assignAll(filtered
          .map((e) => {
                'gerakan_name': e['gerakan_name'] ?? e['gerakanName'] ?? '-',
                'score': double.tryParse(e['score'].toString()) ?? 0.0,
              })
          .toList());

      print('✅ Riwayat untuk ${tariName.value} berhasil dimuat');
    } catch (e) {
      print('❌ Error saat mengambil riwayat: $e');
    } finally {
      isLoading(false);
    }
  }
}
