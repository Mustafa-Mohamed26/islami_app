import 'package:flutter/material.dart';
import 'package:islami_app/util/app_styles.dart';

class SuraContent extends StatelessWidget {
  String suraContent;
  SuraContent({super.key, required this.suraContent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Text(
        suraContent,
        textDirection: TextDirection.rtl, 
        textAlign: TextAlign.center,
        style: AppStyles.bold20Primary,
      ),
    );
  }
}
