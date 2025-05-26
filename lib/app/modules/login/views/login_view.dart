import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';
import 'package:senja_mobile/app/widgets/button_custom.dart';
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
                            Obx(
                              () => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: controller.isChecked.value,
                                        onChanged: (value) => controller
                                            .isChecked.value = value ?? false,
                                        activeColor: PalleteColor.green500,
                                      ),
                                      const Text("Ingat saya"),
                                    ],
                                  ),
                                  TextButton(
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
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: GetPlatform.isWeb ? 600 : double.infinity,
                              child: Obx(() => ButtonCustom(
                                    color: PalleteColor.green550,
                                    textColor: PalleteColor.green50,
                                    name: controller.isLoading.value
                                        ? "Loading..."
                                        : "Masuk",
                                    onPressed: controller.isLoading.value
                                        ? null
                                        : () => controller.handleLogin(),
                                    height: 55,
                                  )),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                                width:
                                    GetPlatform.isWeb ? 600 : double.infinity,
                                child: Obx(() => ButtonCustom(
                                      name: "",
                                      onPressed: controller
                                              .isLoadingGoogle.value
                                          ? null
                                          : () => controller.loginWithGoogle(),
                                      height: 55,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          controller.isLoadingGoogle.value
                                              ? const SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    color:
                                                        PalleteColor.green500,
                                                  ),
                                                )
                                              : const FaIcon(
                                                  FontAwesomeIcons.google,
                                                  color: PalleteColor.green550,
                                                ),
                                          const SizedBox(width: 8),
                                          Text(
                                            controller.isLoadingGoogle.value
                                                ? "Loading..."
                                                : "Masuk dengan Google",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: PalleteColor.green550,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))),
                            const SizedBox(height: 10),
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
