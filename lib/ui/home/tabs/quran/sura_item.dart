import 'package:flutter/material.dart';
import 'package:islami_app/ui/home/tabs/quran/quran_resources.dart';
import 'package:islami_app/util/app_assets.dart';
import 'package:islami_app/util/app_styles.dart';

class SuraItem extends StatelessWidget {
  int index;
  SuraItem({super.key, required this.index});

  // Build the SuraItem widget
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        _buildSuraNumber(),
        SizedBox(width: width * 0.04),
        _buildSuraDetails(),
        const Spacer(),
        _buildSuraArabicName(),
      ],
    );
  }

  // Build the Sura number widget with a background image
  Widget _buildSuraNumber() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(AppAssets.vectorImage),
        Text('${index + 1}', style: AppStyles.bold16White),
      ],
    );
  }

  // Build the Sura details widget showing the English name and number of verses
  Widget _buildSuraDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          QuranResources.englishQuranList[index],
          style: AppStyles.bold20White,
        ),
        Text(
          '${QuranResources.versesNumberList[index]} verses',
          style: AppStyles.bold14White,
        ),
      ],
    );
  }

  // Build the Sura Arabic name widget
  Widget _buildSuraArabicName() {
    return Text(
      QuranResources.arabicQuranList[index],
      style: AppStyles.bold20White,
    );
  }
}
