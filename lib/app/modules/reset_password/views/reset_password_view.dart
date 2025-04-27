import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';
import 'package:senja_mobile/app/widgets/password_field.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PalleteColor.green50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: PalleteColor.green50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: PalleteColor.green200, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: PalleteColor.green900.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Reset Password",
                      style: TextStyle(
                        fontSize: 24,
                        color: PalleteColor.green900,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Silahkan masukkan password baru anda. Dan masukkan ulang password di bawah ini.",
                      style: TextStyle(
                        fontSize: 16,
                        color: PalleteColor.green900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    PasswordField(
                      hint: 'Silahkan masukkan password baru',
                      controller: controller.passwordController,
                      isHidden: controller.isHiddenPassword,
                    ),
                    PasswordField(
                      hint: 'Silahkan masukkan kembali password baru',
                      controller: controller.confirmPasswordController,
                      isHidden: controller.isHiddenConfirm,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if (controller.passwordController.text.isEmpty ||
                                controller.passwordController.text.isEmpty) {
                              Get.snackbar(
                                "Error",
                                "Textfield tidak boleh kosong",
                              );
                            } else if (controller.passwordController.text !=
                                controller.passwordController.text) {
                              Get.snackbar(
                                "Error",
                                "Password tidak sama",
                              );
                            } else {
                              Get.toNamed('/login');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PalleteColor.green550,
                            foregroundColor: PalleteColor.green50,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            "Reset Password",
                            style: TextStyle(color: PalleteColor.green50),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
