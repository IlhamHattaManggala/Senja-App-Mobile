// import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';
import 'package:senja_mobile/app/widgets/button_custom.dart';

import '../controllers/splashscreen_controller.dart';

class SplashscreenView extends GetView<SplashscreenController> {
  const SplashscreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PalleteColor.green550,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/Logo Splash.png',
                    width: 250, height: 250),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'SELAMAT DATANG',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, color: PalleteColor.green50),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'DI SENJA MOBILE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            color: PalleteColor.green50,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Aplikasi Edukasi Mengenai Kesenian Jawa. Seperti Belajar Tari Tradisional, dan terdapat penjelasan mengenai gamelan, wayang kulit, tari tradisional, aksara jawa',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12, color: PalleteColor.green50),
                      ),
                      const SizedBox(height: 15),
                      Obx(() {
                        final isVisible = controller.showButton.value;
                        return AnimatedSlide(
                          offset: isVisible ? Offset.zero : const Offset(0, 1),
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeOut,
                          child: AnimatedOpacity(
                            opacity: isVisible ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 700),
                            // ruang supaya animasi kelihatan
                            child: ButtonCustom(
                              key: Key('Button Mulai'),
                              height: 55,
                              name: 'Mulai',
                              rightIcon: Icon(Icons.arrow_forward),
                              onPressed: () => Get.toNamed('/overview'),
                              textColor: PalleteColor.green550,
                              color: PalleteColor.green50,
                            ),
                          ),
                        );
                      })
                      // SizedBox(
                      //   width: double.infinity,
                      //   height: 55,
                      //   child: ElevatedButton.icon(
                      //     key: const Key('Button Mulai'),
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: PalleteColor.green50,
                      //       foregroundColor: PalleteColor.green550,
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(12),
                      //       ),
                      //     ),
                      //     icon: const Icon(Icons.arrow_forward),
                      //     label: const Text(
                      //       'Mulai',
                      //       style: TextStyle(fontSize: 16),
                      //     ),
                      //     onPressed: () => Get.toNamed('/overview'),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
