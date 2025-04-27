import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';

class InputField extends StatelessWidget {
  final String? label;
  final String hint;
  final TextEditingController controller;
  final IconData prefixIcon;

  const InputField({
    super.key,
    this.label,
    required this.hint,
    required this.controller,
    required this.prefixIcon,
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
            width: GetPlatform.isWeb ? 600 : double.infinity,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: PalleteColor.green50,
                prefixIcon: Icon(prefixIcon),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      const BorderSide(color: PalleteColor.green550, width: 2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
