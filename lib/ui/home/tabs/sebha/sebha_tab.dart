import 'package:flutter/material.dart';
import 'package:islami_app/util/app_assets.dart';
import 'package:islami_app/util/app_styles.dart';

class SebhaTab extends StatelessWidget {
  const SebhaTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Text("سَبِّحِ اسْمَ رَبِّكَ الأعلى ", style: AppStyles.bold36white,),
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(AppAssets.sebha),
            Column(
              children: [
                SizedBox(height: height*0.12,),
                Text("سبحان الله", style: AppStyles.bold36white,),
                Text("30", style: AppStyles.bold36white,),
              ],
            )
          ],
        )
      ],
    );
  }
}