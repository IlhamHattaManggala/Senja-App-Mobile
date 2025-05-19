import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';
import 'package:senja_mobile/app/widgets/input_field.dart';

import '../controllers/lupa_password_controller.dart';

class LupaPasswordView extends GetView<LupaPasswordController> {
  const LupaPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PalleteColor.green50,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.toNamed('/login'),
          color: PalleteColor.green50,
        ),
        backgroundColor: PalleteColor.green550,
        title: const Text('Lupa Kata Sandi'),
        centerTitle: true,
        foregroundColor: PalleteColor.green50,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: PalleteColor.green50,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: PalleteColor.green900.withOpacity(0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: PalleteColor.green900.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // const SizedBox(height: 16),
              Text(
                'Masukkan email kamu untuk mereset kata sandi.',
                style: TextStyle(
                  fontSize: 14,
                  color: PalleteColor.green900,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              InputField(
                hint: 'contoh@email.com',
                controller: controller.emailController,
                prefixIcon: Icons.email,
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.kirimPermintaanReset,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PalleteColor.green550,
                    foregroundColor: PalleteColor.green50,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text('Kirim Permintaan Reset'),
                ),
                // child: Obx(() => ElevatedButton(
                //       onPressed: controller.isLoading.value
                //           ? null
                //           : controller.kirimPermintaanReset,
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: PalleteColor.green550,
                //         foregroundColor: PalleteColor.green50,
                //         padding: const EdgeInsets.symmetric(
                //             horizontal: 50, vertical: 15),
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(30),
                //         ),
                //       ),
                //       child: controller.isLoading.value
                //           ? const CircularProgressIndicator(
                //               color: PalleteColor.green50,
                //             )
                //           : const Text("Kirim", style: TextStyle(fontSize: 16)),
                //     )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
