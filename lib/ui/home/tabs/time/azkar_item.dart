import 'package:flutter/material.dart';
import 'package:islami_app/util/app_color.dart';
import 'package:islami_app/util/app_styles.dart';

class AzkarItem extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback? onTap;

  const AzkarItem({
    super.key,
    required this.image,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: AppColor.blackBgColor,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: AppColor.primaryColor, width: 2.0),
          ),
          child: Column(
            children: [
              Image.asset(image),
              Text(title, style: AppStyles.bold20White),
            ],
          ),
        ),
      ),
    );
  }
}
