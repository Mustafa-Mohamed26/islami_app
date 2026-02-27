import 'package:flutter/material.dart';
import 'package:islami_app/util/app_styles.dart';

class SuraContent extends StatelessWidget {
  String suraContent;
  SuraContent({super.key, required this.suraContent});

  // Build the SuraContent widget
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: _buildTextContent(),
    );
  }

  // Build the text content for the SuraContent widget
  Widget _buildTextContent() {
    return Text(
      suraContent,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.center,
      style: AppStyles.bold20Primary,
    );
  }
}
