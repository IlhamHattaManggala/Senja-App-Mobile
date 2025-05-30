import 'package:flutter/material.dart';
import 'package:senja_mobile/app/config/pallete_color.dart';

class ButtonCustom extends StatelessWidget {
  final String name;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final double? height;
  final Widget? child;

  const ButtonCustom({
    super.key,
    required this.name,
    this.leftIcon,
    this.rightIcon,
    this.onPressed,
    this.color,
    this.borderColor,
    this.textColor,
    this.height,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: SizedBox(
        width: double.infinity,
        height: height ?? 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? PalleteColor.green50,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                  color: borderColor ?? Colors.transparent, width: 2.0),
            ),
          ),
          onPressed: onPressed,
          child: child ??
              Row(
                mainAxisAlignment: (leftIcon != null && rightIcon != null)
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.center,
                children: [
                  if (leftIcon != null) ...[
                    leftIcon!,
                    const SizedBox(width: 8),
                  ],
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: textColor ?? PalleteColor.green900,
                    ),
                  ),
                  if (rightIcon != null) ...[
                    const SizedBox(width: 8),
                    rightIcon!,
                  ],
                ],
              ),
        ),
      ),
    );
  }
}
