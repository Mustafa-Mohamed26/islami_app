import 'package:flutter/material.dart';
import '../../../../../util/app_color.dart';
import '../../../../../util/app_styles.dart';
import '../azkar_data.dart';

class AzkarCard extends StatelessWidget {
  final AzkarEntry entry;

  const AzkarCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColor.blackBgColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColor.primaryColor, width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Repeat badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColor.primaryColor, width: 1),
            ),
            child: Text(
              entry.repeatCount == 1 ? 'Once' : '× ${entry.repeatCount}',
              style: AppStyles.bold14White,
            ),
          ),

          const SizedBox(height: 24),

          // Arabic text
          Text(
            entry.arabic,
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColor.whiteColor,
              height: 2.0,
              fontFamily: 'Amiri',
            ),
          ),

          const SizedBox(height: 20),

          const Divider(color: AppColor.primaryColor, thickness: 1),

          const SizedBox(height: 16),

          // Translation
          Text(
            entry.translation,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: AppColor.whiteColor,
              height: 1.6,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
