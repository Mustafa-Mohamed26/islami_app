import 'package:flutter/material.dart';
import 'package:islami_app/util/app_color.dart';
import 'package:islami_app/util/app_styles.dart';

typedef OnClick = void Function();
class SuraContentItem extends StatelessWidget {
  final String suraContent;
  final int index;
  final bool isSelected;
  final OnClick onTap;

  const SuraContentItem({
    super.key,
    required this.suraContent,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.04),
        padding: EdgeInsets.symmetric(vertical: height * 0.01),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primaryColor : AppColor.transparentColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: AppColor.primaryColor,
            width: 2,
          ),
        ),
        child: Text(
          "${suraContent} [${index + 1}]",
          style: AppStyles.bold20Primary.copyWith(
            color: isSelected ? AppColor.blackColor : AppColor.primaryColor,
          ),
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
