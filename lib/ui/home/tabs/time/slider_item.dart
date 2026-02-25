import 'package:flutter/material.dart';
import 'package:islami_app/model/time_model.dart';
import 'package:islami_app/util/app_color.dart';
import 'package:islami_app/util/app_styles.dart';
import 'package:islami_app/util/date_formatter.dart';

class SliderItem extends StatelessWidget {
  String name;
  String time;
  TimeModel? prayer;
  SliderItem({super.key,  this.prayer, required this.name, required this.time});

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
          Text(name, style: AppStyles.bold16White),
          Text(TimeConverter.to12Hour(time), style: AppStyles.bold20White),
          
        ],
      ),
    );
  }
}
