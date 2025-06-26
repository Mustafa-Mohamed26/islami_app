import 'dart:ui';

import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islami_app/util/app_color.dart';

class AppStyles {
  static TextStyle bold16White = GoogleFonts.elMessiri(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColor.whiteColor,
  );
  static TextStyle bold20White = GoogleFonts.elMessiri(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColor.whiteColor,
  );
  static TextStyle bold24Black = GoogleFonts.elMessiri(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColor.blackColor,
  );
  static TextStyle bold14black = GoogleFonts.elMessiri(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColor.blackColor,
  );
  static TextStyle bold14White = GoogleFonts.elMessiri(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColor.whiteColor,
  );
  static TextStyle bold20Primary = GoogleFonts.elMessiri(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColor.primaryColor,
  );
  static TextStyle bold24Primary = GoogleFonts.elMessiri(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColor.primaryColor,
  );
  
}