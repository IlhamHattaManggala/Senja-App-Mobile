import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:senja_mobile/app/data/models/log_activity.dart';
import 'package:senja_mobile/app/data/providers/api_provider.dart';
import 'package:senja_mobile/app/data/storage/storage.dart';

class LogActivityController extends GetxController {
  final api = Get.find<ApiProvider>();
  final storage = Get.find<Storage>();
  var logList = <LogActivity>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    Intl.defaultLocale = 'id_ID';
    fetchData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void fetchData() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final result = await api.fetchLogActivity();
      logList.value = result;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  String formatDateOnly(String rawDateTime) {
    try {
      final dateTime = DateTime.parse(rawDateTime.replaceFirst(' ', 'T'));
      final formatted = DateFormat('dd MMMM yyyy', 'id_ID').format(dateTime);
      return formatted;
    } catch (e) {
      print("Gagal parse tanggal: $e");
      return rawDateTime;
    }
  }

  String formatTimeOnly(String rawDateTime) {
    try {
      final dateTime = DateTime.parse(rawDateTime.replaceFirst(' ', 'T'));
      return DateFormat('HH:mm', 'id_ID').format(dateTime);
    } catch (e) {
      print("Gagal parse waktu: $e");
      return rawDateTime;
    }
  }
}
