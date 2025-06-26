import 'package:flutter/material.dart';
import 'package:islami_app/util/app_color.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColor.transparentColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColor.whiteColor,
      unselectedItemColor: AppColor.blackColor,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColor.blackBgColor,
      iconTheme: IconThemeData(color: AppColor.primaryColor),
    ),
  );
}
