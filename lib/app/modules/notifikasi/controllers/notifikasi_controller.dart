import 'package:get/get.dart';
import 'package:senja_mobile/app/data/models/notifikasi.dart';
import 'package:senja_mobile/app/data/providers/api_provider.dart';
import 'package:senja_mobile/app/data/storage/storage.dart';

class NotifikasiController extends GetxController {
  final count = 0.obs;
  var isLoading = true.obs;
  var notifikasi = {}.obs;
  var notif = <Notifikasi>[].obs;
  final api = Get.find<ApiProvider>();
  final storage = Get.find<Storage>();

  @override
  void onInit() {
    super.onInit();
    fetchNotifikasi();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchNotifikasi() async {
    try {
      isLoading(true);
      final fetchedNotifikasi = await api.fetchNotifikasi();
      notif.assignAll(fetchedNotifikasi);
    } catch (e) {
      print("Error fetching notifikasi: $e");
    } finally {
      isLoading(false); // Set loading status false setelah selesai
    }
  }

  Future<void> updateNotif(Notifikasi notif) async {
    try {
      await api.markNotifAsRead(notif.id);
      final index = this.notif.indexWhere((n) => n.id == notif.id);
      if (index != -1) {
        this.notif[index].isRead = true;
        this.notif.refresh();
      }
    } catch (e) {
      print("Gagal update notif: $e");
    }
  }

  Future<void> deleteNotif(Notifikasi notif) async {
    try {
      await api.deleteNotifFromBackend(notif.id);
      this.notif.removeWhere((n) => n.id == notif.id);
    } catch (e) {
      print("Gagal hapus notif: $e");
    }
  }

  final data = {
    'title': 'Tidak ada notifikasi Masuk!',
    'message': 'Silahkan cek lagi nanti...',
    'created_at': DateTime.now().toIso8601String(),
    'isRead': false,
    'info': 'Informasi lebih lengkap klik disini..',
  };
}
