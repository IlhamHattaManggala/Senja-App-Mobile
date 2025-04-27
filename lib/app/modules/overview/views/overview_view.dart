import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';

import '../controllers/overview_controller.dart';

class OverviewView extends GetView<OverviewController> {
  const OverviewView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PalleteColor.green550,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(), // Mendorong konten ke tengah
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Belajar Tari Lebih Mudah',
                  style: TextStyle(
                      color: PalleteColor.green50,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Langkah Demi Langkah',
                  style: TextStyle(
                      color: PalleteColor.green700,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset('assets/images/Logo Splash.png',
                    width: 250, height: 250),
                const SizedBox(height: 40),
                SizedBox(
                  width: 300,
                  height: 40, // Atur lebar button (ubah sesuai kebutuhan)
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PalleteColor.green600,
                    ),
                    onPressed: () => Get.toNamed('/register'),
                    child: Text(
                      'Buat Akun',
                      style: TextStyle(
                        color: PalleteColor.green50,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(), // Mendorong RichText ke bawah
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 20), // Jaga jarak dari bawah
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: PalleteColor.green50, fontSize: 18),
                  children: [
                    TextSpan(
                      text: 'Sudah punya akun? ',
                      style: TextStyle(color: PalleteColor.green50),
                    ),
                    TextSpan(
                      text: 'Login disini',
                      style: TextStyle(
                        color: PalleteColor.green700,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.toNamed('/login'); // Navigasi ke halaman login
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
