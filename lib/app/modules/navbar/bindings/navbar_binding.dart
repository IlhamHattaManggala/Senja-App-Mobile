import 'package:get/get.dart';
import 'package:senja_mobile/app/data/providers/api_provider.dart';
import 'package:senja_mobile/app/data/storage/storage.dart';
import 'package:senja_mobile/app/modules/account/controllers/account_controller.dart';
import 'package:senja_mobile/app/modules/history/controllers/history_controller.dart';
import 'package:senja_mobile/app/modules/home/controllers/home_controller.dart';
import 'package:senja_mobile/app/modules/laporan/controllers/laporan_controller.dart';
import 'package:senja_mobile/app/modules/notifikasi/controllers/notifikasi_controller.dart';
import 'package:senja_mobile/app/modules/riwayat/controllers/riwayat_controller.dart';

import '../controllers/navbar_controller.dart';

class NavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavbarController>(() => NavbarController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<HistoryController>(() => HistoryController());
    Get.lazyPut<NotifikasiController>(() => NotifikasiController());
    Get.lazyPut<AccountController>(() => AccountController());
    Get.lazyPut<RiwayatController>(() => RiwayatController());
    Get.lazyPut<LaporanController>(() => LaporanController());
    Get.lazyPut<ApiProvider>(() => ApiProvider());
    Get.lazyPut<Storage>(() => Storage());
  }
}
