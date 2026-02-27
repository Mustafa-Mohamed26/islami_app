import 'package:flutter/material.dart';
import '../../../../../util/app_color.dart';

class AzkarNavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const AzkarNavButton({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final active = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: active
              ? AppColor.primaryColor.withOpacity(0.15)
              : Colors.transparent,
          border: Border.all(
            color: active
                ? AppColor.primaryColor.withOpacity(0.6)
                : Colors.white12,
          ),
        ),
        child: Icon(
          icon,
          color: active ? AppColor.primaryColor : Colors.white24,
          size: 18,
        ),
      ),
    );
  }
}
