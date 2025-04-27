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

  // Method untuk memuat data gerakan dari API atau sumber data lainnya
  void _loadGerakanData() {
    // TODO: Implementasikan logika untuk memuat data gerakan
    // Contoh: memanggil API service untuk mendapatkan data gerakan tari
  }
  void onGerakanTapped(int gerakanId) {
    // Navigate to Laporan page with default values if data is null
    Get.toNamed('/laporan', arguments: {
      'gerakanId': gerakanId,
      'tariName': 'Tari Gambyong', // Default value
      // Add any other necessary parameters with default values
    });
  }
  // Method untuk menangani ketika gerakan di-tap
  // void onGerakanTapped(int gerakanId) {
  //   // Simpan gerakan yang dipilih
  //   selectedGerakanId.value = gerakanId;

  //   // Tambahkan ke histori jika belum ada
  //   if (!viewedGerakans.contains(gerakanId)) {
  //     viewedGerakans.add(gerakanId);
  //   }

  //   // Navigasi ke detail gerakan
  //   _navigateToGerakanDetail(gerakanId);
  // }

  // Method untuk navigasi ke halaman detail gerakan
  // void _navigateToGerakanDetail(int gerakanId) {
  //   // Navigasi ke halaman detail gerakan
  //   Get.toNamed('/gerakan-detail/$gerakanId');

  //   // Alternatif: jika menggunakan parameter
  //   // Get.toNamed('/gerakan-detail', arguments: {'id': gerakanId});
  // }

  // Method untuk mendapatkan info gerakan berdasarkan ID
  Map<String, dynamic> getGerakanInfo(int gerakanId) {
    // TODO: Implementasikan logika untuk mendapatkan info gerakan
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
  void markGerakanAsCompleted(int gerakanId) {
    // TODO: Implementasikan logika untuk menandai gerakan sebagai selesai
    print('Gerakan $gerakanId ditandai sebagai selesai');
    // Mungkin perlu update ke API atau database lokal
  }
}
