import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';
import 'package:senja_mobile/app/modules/account/views/account_view.dart';
// import 'package:senja_mobile/app/modules/history/views/history_view.dart';
import 'package:senja_mobile/app/modules/home/views/home_view.dart';
import 'package:senja_mobile/app/modules/notifikasi/views/notifikasi_view.dart';
import 'package:senja_mobile/app/modules/riwayat/views/riwayat_view.dart';

import '../controllers/navbar_controller.dart';

class NavbarView extends GetView<NavbarController> {
  const NavbarView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.currentIndex.value,
            children: const [
              HomeView(),
              // HistoryView(),
              RiwayatView(),
              NotifikasiView(),
              AccountView(),
            ],
          )),
      bottomNavigationBar: Obx(() => CurvedNavigationBar(
            index: controller.currentIndex.value,
            onTap: (index) => controller.changeIndex(index),
            backgroundColor: Color(0xFFFDF5E6),
            color: Color(0xFF7A651F),
            buttonBackgroundColor: Color(0xFF7A651F),
            height: 60,
            items: const [
              Icon(Icons.home, size: 30, color: PalleteColor.green50),
              Icon(Icons.history, size: 30, color: PalleteColor.green50),
              Icon(Icons.notifications, size: 30, color: PalleteColor.green50),
              Icon(Icons.person, size: 30, color: PalleteColor.green50),
            ],
          )),
    );
  }
}
