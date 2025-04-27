import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';
import '../controllers/verifikasi_controller.dart';

class VerifikasiView extends GetView<VerifikasiController> {
  const VerifikasiView({super.key});

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
                      "Verifikasi PIN",
                      style: TextStyle(
                        fontSize: 24,
                        color: PalleteColor.green900,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Silahkan cek email anda untuk mendapatkan PIN verifikasi. Dan masukkan PIN di bawah ini.",
                      style: TextStyle(
                        fontSize: 16,
                        color: PalleteColor.green900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: 300,
                      child: PinCodeTextField(
                        appContext: context,
                        controller: controller.pinController,
                        length: 6,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        keyboardType: TextInputType.number,
                        autoFocus: true,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(12),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.white,
                          selectedFillColor: Colors.white,
                          inactiveFillColor: Colors.white,
                          activeColor: PalleteColor.green550,
                          selectedColor: PalleteColor.green550,
                          inactiveColor: Colors.grey.shade300,
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                        onPressed: () {
                          if (controller.pinController.text.isEmpty) {
                            Get.snackbar(
                              "Error",
                              "Textfield tidak boleh kosong",
                            );
                          } else {
                            Get.toNamed('/reset-password');
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
                          "Kirim PIN",
                          style: TextStyle(color: PalleteColor.green50),
                        )),
                    // Obx(() => ElevatedButton(
                    //       onPressed: controller.isLoading.value
                    //           ? null
                    //           : controller.kirimVerifikasiPin,
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
                    //           : const Text(
                    //               "Verifikasi",
                    //               style: TextStyle(fontSize: 16),
                    //             ),
                    //     )),
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
