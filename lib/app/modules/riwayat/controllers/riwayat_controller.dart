import 'package:get/get.dart';

class RiwayatController extends GetxController {
  // Variabel untuk menyimpan ID atau indeks gerakan yang aktif/terpilih
  final RxInt selectedGerakanId = 0.obs;

  // Menyimpan histori gerakan yang telah dilihat
  final RxList<int> viewedGerakans = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Inisialisasi data atau ambil data dari API jika diperlukan
    _loadGerakanData();
  }

  @override
  void onReady() {
    super.onReady();
    // Kode yang akan dijalankan setelah widget dirender
  }

  @override
  void onClose() {
    super.onClose();
    // Bersihkan resources jika diperlukan
  }

  void _loadGerakanData() {}
  void onGerakanTapped(String tariName) {
    // Navigate to Laporan page with default values if data is null
    Get.toNamed('/laporan', arguments: {
      'tariName': tariName,
    });
  }

  Map<String, dynamic> getGerakanInfo(int gerakanId) {
    // Ini adalah contoh mock data
    return {
      'id': gerakanId,
      'nama': 'Gerakan $gerakanId',
      'deskripsi':
          'Deskripsi lengkap untuk gerakan $gerakanId dalam tari Gambyong',
      'videoUrl': 'https://example.com/video/gerakan$gerakanId.mp4',
    };
  }

  // Method untuk menandai gerakan sebagai selesai dipelajari
  void markGerakanAsCompleted(int gerakanId) {}
}
