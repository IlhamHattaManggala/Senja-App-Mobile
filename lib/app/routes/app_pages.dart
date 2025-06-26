import 'package:get/get.dart';

import '../modules/account/bindings/account_binding.dart';
import '../modules/account/views/account_view.dart';
import '../modules/bantuan/bindings/bantuan_binding.dart';
import '../modules/bantuan/views/bantuan_view.dart';
import '../modules/berita/bindings/berita_binding.dart';
import '../modules/berita/views/berita_view.dart';
import '../modules/detail/bindings/detail_binding.dart';
import '../modules/detail/views/detail_view.dart';
import '../modules/detail_notif/bindings/detail_notif_binding.dart';
import '../modules/detail_notif/views/detail_notif_view.dart';
import '../modules/gerakan/bindings/gerakan_binding.dart';
import '../modules/gerakan/views/gerakan_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/laporan/bindings/laporan_binding.dart';
import '../modules/laporan/views/laporan_view.dart';
import '../modules/log_activity/bindings/log_activity_binding.dart';
import '../modules/log_activity/views/log_activity_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/lupa_password/bindings/lupa_password_binding.dart';
import '../modules/lupa_password/views/lupa_password_view.dart';
import '../modules/monitoring/bindings/monitoring_binding.dart';
import '../modules/monitoring/views/monitoring_view.dart';
import '../modules/navbar/bindings/navbar_binding.dart';
import '../modules/navbar/views/navbar_view.dart';
import '../modules/notifikasi/bindings/notifikasi_binding.dart';
import '../modules/notifikasi/views/notifikasi_view.dart';
import '../modules/overview/bindings/overview_binding.dart';
import '../modules/overview/views/overview_view.dart';
import '../modules/pengaturan_akun/bindings/pengaturan_akun_binding.dart';
import '../modules/pengaturan_akun/views/pengaturan_akun_view.dart';
import '../modules/preview/bindings/preview_binding.dart';
import '../modules/preview/views/preview_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/riwayat/bindings/riwayat_binding.dart';
import '../modules/riwayat/views/riwayat_view.dart';
import '../modules/splashscreen/bindings/splashscreen_binding.dart';
import '../modules/splashscreen/views/splashscreen_view.dart';
import '../modules/tentang/bindings/tentang_binding.dart';
import '../modules/tentang/views/tentang_view.dart';
import '../modules/verifikasi/bindings/verifikasi_binding.dart';
import '../modules/verifikasi/views/verifikasi_view.dart';
import '../modules/verify-email/bindings/verify_email_binding.dart';
import '../modules/verify-email/views/verify_email_view.dart';
import '../modules/visualisasi/bindings/visualisasi_binding.dart';
import '../modules/visualisasi/views/visualisasi_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHSCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASHSCREEN,
      page: () => SplashscreenView(),
      binding: SplashscreenBinding(),
    ),
    GetPage(
      name: _Paths.OVERVIEW,
      page: () => OverviewView(),
      binding: OverviewBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.NAVBAR,
      page: () => NavbarView(),
      binding: NavbarBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT,
      page: () => AccountView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFIKASI,
      page: () => NotifikasiView(),
      binding: NotifikasiBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => const DetailView(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: _Paths.MONITORING,
      page: () => const MonitoringView(),
      binding: MonitoringBinding(),
    ),
    GetPage(
      name: _Paths.GERAKAN,
      page: () => const GerakanView(),
      binding: GerakanBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT,
      page: () => const RiwayatView(),
      binding: RiwayatBinding(),
    ),
    GetPage(
      name: _Paths.LAPORAN,
      page: () => const LaporanView(),
      binding: LaporanBinding(),
    ),
    GetPage(
      name: _Paths.TENTANG,
      page: () => const TentangView(),
      binding: TentangBinding(),
    ),
    GetPage(
      name: _Paths.BANTUAN,
      page: () => const BantuanView(),
      binding: BantuanBinding(),
    ),
    GetPage(
      name: _Paths.PENGATURAN_AKUN,
      page: () => const PengaturanAkunView(),
      binding: PengaturanAkunBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_NOTIF,
      page: () => const DetailNotifView(),
      binding: DetailNotifBinding(),
    ),
    GetPage(
      name: _Paths.LUPA_PASSWORD,
      page: () => const LupaPasswordView(),
      binding: LupaPasswordBinding(),
    ),
    GetPage(
      name: _Paths.VERIFIKASI,
      page: () => const VerifikasiView(),
      binding: VerifikasiBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY_EMAIL,
      page: () => const VerifyEmailView(),
      binding: VerifyEmailBinding(),
    ),
    GetPage(
      name: _Paths.BERITA,
      page: () => const BeritaView(),
      binding: BeritaBinding(),
    ),
    GetPage(
      name: _Paths.LOG_ACTIVITY,
      page: () => const LogActivityView(),
      binding: LogActivityBinding(),
    ),
    GetPage(
      name: _Paths.VISUALISASI,
      page: () => const VisualisasiView(),
      binding: VisualisasiBinding(),
    ),
    GetPage(
      name: _Paths.PREVIEW,
      page: () => const PreviewView(),
      binding: PreviewBinding(),
    ),
  ];
}
