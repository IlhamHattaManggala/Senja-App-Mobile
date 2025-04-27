import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';
import 'package:senja_mobile/app/widgets/input_field.dart';
import 'package:senja_mobile/app/widgets/password_field.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PalleteColor.green550,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: PalleteColor.green50,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                "Daftar",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: PalleteColor.green550,
                                ),
                              ),
                              const SizedBox(height: 20),
                              InputField(
                                label: "Nama Lengkap",
                                hint: "Silahkan masukkan nama lengkap",
                                controller: controller.nameController,
                                prefixIcon: Icons.person,
                              ),
                              const SizedBox(height: 10),
                              InputField(
                                label: "Email",
                                hint: "Silahkan masukkan email",
                                controller: controller.emailController,
                                prefixIcon: Icons.email,
                              ),
                              const SizedBox(height: 10),
                              PasswordField(
                                label: "Kata Sandi",
                                hint: "Silahkan masukkan kata sandi",
                                controller: controller.passwordController,
                                isHidden: controller.isHiddenPass,
                              ),
                              const SizedBox(height: 10),
                              PasswordField(
                                label: "Ulangi Kata Sandi",
                                hint: "Silahkan masukkan ulang kata sandi",
                                controller:
                                    controller.confirmPasswordController,
                                isHidden: controller.isHiddenConfirmPass,
                              ),
                              const SizedBox(height: 10),
                              Obx(() => Row(
                                    children: [
                                      Checkbox(
                                        activeColor: PalleteColor.green550,
                                        value: controller.isChecked.value,
                                        onChanged: (value) {
                                          controller.isChecked.value =
                                              value ?? false;
                                        },
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Dengan ini saya menyetujui syarat & ketentuan berlaku",
                                          style: TextStyle(
                                              color: PalleteColor.green550),
                                        ),
                                      ),
                                    ],
                                  )),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                child: Obx(() => ElevatedButton(
                                      onPressed: controller.isLoading.value ||
                                              !controller.isChecked.value
                                          ? null
                                          : () => controller.handleRegister(),
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 50, vertical: 15),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        backgroundColor:
                                            controller.isChecked.value
                                                ? PalleteColor.green550
                                                : Colors.grey,
                                        foregroundColor: PalleteColor.green50,
                                      ),
                                      child: controller.isLoading.value
                                          ? const CircularProgressIndicator(
                                              color: PalleteColor.green500)
                                          : Text(
                                              "Daftar",
                                              style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                    )),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),

                      // 🔽 Spacer pakai Expanded biar kontennya ke bawah
                      Expanded(child: Container()),

                      // 🔽 Footer "Sudah punya akun?"
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: PalleteColor.green550,
                            ),
                            children: [
                              TextSpan(
                                text: 'Sudah punya akun? ',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: PalleteColor.green50,
                                ),
                              ),
                              TextSpan(
                                text: 'Login disini',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: PalleteColor.green900,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed('/login');
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
