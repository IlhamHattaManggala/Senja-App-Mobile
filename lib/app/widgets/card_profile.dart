import 'package:flutter/material.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';

class CardProfile extends StatelessWidget {
  final String label;
  final IconData leftIcon;
  final VoidCallback? onTap;

  const CardProfile({
    super.key,
    required this.label,
    required this.leftIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: PalleteColor.green50,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: PalleteColor.green550.withOpacity(0.3),
                blurRadius: 4,
                spreadRadius: 1,
                offset: const Offset(1, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(leftIcon, color: PalleteColor.green550),
                  const SizedBox(width: 10),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: PalleteColor.green550,
                    ),
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios, color: PalleteColor.green550),
            ],
          ),
        ),
      ),
    );
  }
}
