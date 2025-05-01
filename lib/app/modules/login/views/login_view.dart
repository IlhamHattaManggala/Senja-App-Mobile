import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';
import 'package:senja_mobile/app/widgets/input_field.dart';
import 'package:senja_mobile/app/widgets/password_field.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Color
          Container(
            decoration: BoxDecoration(color: PalleteColor.green550),
          ),
          // Kontainer dengan Lengkungan
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 80),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: PalleteColor.green50,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: PalleteColor.green500,
                              ),
                            ),
                            const SizedBox(height: 20),
                            InputField(
                              label: "Email",
                              hint: "Silahkan masukkan email",
                              controller: controller.emailController,
                              prefixIcon: Icons.email,
                            ),
                            PasswordField(
                              label: "Kata Sandi",
                              hint: "Silahkan masukkan kata sandi",
                              controller: controller.passwordController,
                              isHidden: controller.isHiddenPass,
                            ),
                            const SizedBox(height: 2),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Get.toNamed('/lupa-password');
                                },
                                child: Text(
                                  'Lupa kata sandi?',
                                  style: TextStyle(
                                    color: PalleteColor.green500,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: GetPlatform.isWeb ? 600 : double.infinity,
                              child: Obx(
                                () => ElevatedButton(
                                  onPressed: controller.isLoading.value
                                      ? null
                                      : () => controller.handleLogin(),
                                  // onPressed: controller.isLoading.value
                                  //     ? null
                                  //     : () => Get.offAllNamed('/beranda'),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    backgroundColor: PalleteColor.green550,
                                    foregroundColor: PalleteColor.green50,
                                  ),
                                  child: controller.isLoading.value
                                      ? const CircularProgressIndicator(
                                          color: PalleteColor.green500)
                                      : const Text("Masuk",
                                          style: TextStyle(fontSize: 16)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Ini fix di bawah
                Container(
                  width: double.infinity,
                  color: PalleteColor.green50,
                  padding: const EdgeInsets.all(16),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        color: PalleteColor.green900,
                        fontSize: 16,
                      ),
                      children: [
                        const TextSpan(text: 'Belum punya akun? '),
                        TextSpan(
                          text: 'Daftar disini',
                          style: TextStyle(
                            color: PalleteColor.green550,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed('/register');
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
