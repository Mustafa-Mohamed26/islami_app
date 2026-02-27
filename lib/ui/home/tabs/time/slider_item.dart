import 'package:flutter/material.dart';
import 'package:islami_app/util/app_color.dart';
import 'package:islami_app/util/app_styles.dart';
import 'package:islami_app/util/date_formatter.dart';

/// A single card in the prayer-times carousel.
class SliderItem extends StatelessWidget {
  final String name;
  final String time;

  const SliderItem({super.key, required this.name, required this.time});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      width: width * 0.3,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColor.blackColor, AppColor.transparentColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(name, style: AppStyles.bold16White),
          Text(TimeConverter.to12Hour(time), style: AppStyles.bold20White),
        ],
      ),
    );
  }
}
