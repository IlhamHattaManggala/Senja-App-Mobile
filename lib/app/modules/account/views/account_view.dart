import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';
import 'package:senja_mobile/app/widgets/button_custom.dart';
import 'package:senja_mobile/app/widgets/card_profile.dart';
import 'package:senja_mobile/app/widgets/profile_avatar.dart';

import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              height: 300,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(color: PalleteColor.green550),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Profile',
                          style: TextStyle(
                              fontSize: 16,
                              color: PalleteColor.green50,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Obx(() {
                      final user = controller.user.value;
                      if (user == null) {
                        return const CircularProgressIndicator(); // atau Skeleton
                      }
                      return Column(
                        children: [
                          ProfileAvatar(
                              imageUrl: user.avatar ?? '',
                              onTap: () {
                                print('Tombol Ditekan');
                              }),
                          Text(
                            user.name ?? "name",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: PalleteColor.green50),
                          ),
                          Text(
                            user.email ?? "email@gmail.com",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: PalleteColor.green50),
                          )
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(color: PalleteColor.green50),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Tambahkan ini agar teks rata kiri
                      children: [
                        Text(
                          'Informasi Akun',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: PalleteColor.green900),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Divider(
                          height: 2,
                          color: PalleteColor.green900,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CardProfile(
                          label: 'Pengaturan Akun',
                          leftIcon: Icons.person,
                          onTap: () {
                            if (controller.user.value != null) {
                              Get.toNamed('/pengaturan-akun',
                                  arguments: controller.user.value);
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CardProfile(
                          label: 'Notifikasi',
                          leftIcon: Icons.notifications,
                          onTap: () {
                            controller.navbarController.changeIndex(2);
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CardProfile(
                          label: 'Bantuan & Dukungan',
                          leftIcon: Icons.help,
                          onTap: () {
                            Get.toNamed('/bantuan');
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CardProfile(
                          label: 'Tentang Aplikasi',
                          leftIcon: Icons.info_outline,
                          onTap: () {
                            Get.toNamed('/tentang');
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ButtonCustom(
                          height: 55,
                          name: 'Keluar',
                          leftIcon: Icons.logout,
                          color: PalleteColor.green550,
                          textColor: PalleteColor.green50,
                          onPressed: () {
                            Get.offAllNamed('/login');
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
