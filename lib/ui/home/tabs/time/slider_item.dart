import 'package:flutter/material.dart';
import 'package:islami_app/model/time_model.dart';
import 'package:islami_app/util/app_color.dart';
import 'package:islami_app/util/app_styles.dart';

class SliderItem extends StatelessWidget {
  TimeModel prayer;
  SliderItem({super.key, required this.prayer});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.3,
      height: height * 0.3,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.blackColor, AppColor.transparentColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(prayer.name, style: AppStyles.bold16White),
          Text(prayer.time, style: AppStyles.bold20White),
          Text(prayer.period, style: AppStyles.bold16White),
        ],
      ),
    );
    ;
  }
}
