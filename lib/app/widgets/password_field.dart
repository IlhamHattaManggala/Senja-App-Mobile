import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';

class PasswordField extends StatelessWidget {
  final String? label;
  final String hint;
  final TextEditingController controller;
  final RxBool isHidden;

  const PasswordField({
    super.key,
    this.label,
    required this.hint,
    required this.controller,
    required this.isHidden,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label ?? "",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: PalleteColor.green550,
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 60,
            width: GetPlatform.isWeb ? 600 : double.infinity,
            child: Obx(
              () => TextField(
                controller: controller,
                obscureText: isHidden.value,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: hint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: PalleteColor.green50,
                  prefixIcon: const Icon(Icons.lock),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                        color: PalleteColor.green550, width: 2),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(isHidden.value
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      isHidden.value = !isHidden.value;
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
