import 'package:flutter/material.dart';
import 'package:islami_app/ui/home/tabs/quran/details/sura_details_screen_2.dart';
import 'package:islami_app/ui/home/tabs/quran/details/sura_details_screen_1.dart';
import 'package:islami_app/ui/home/tabs/quran/sura_item.dart';
import 'package:islami_app/util/app_assets.dart';
import 'package:islami_app/util/app_color.dart';
import 'package:islami_app/util/app_styles.dart';

class QuranTab extends StatelessWidget {
  const QuranTab({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.01,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(
            cursorColor: AppColor.primaryColor,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: AppColor.primaryColor, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: AppColor.primaryColor, width: 2),
              ),
              prefixIcon: Image.asset(
                AppAssets.iconQuran,
                color: AppColor.primaryColor,
              ),
              hintText: 'Search in Quran',
              hintStyle: AppStyles.bold16White,
            ),
          ),
          SizedBox(height: height * 0.02),
          Text('Most Recently Read', style: AppStyles.bold16White),
          SizedBox(height: height * 0.01),
          SizedBox(
            height: height * 0.16,
            width: double.infinity,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Al-Anbiya", style: AppStyles.bold24Black),
                          Text("الأنبياء", style: AppStyles.bold24Black),
                          Text("112 Verses", style: AppStyles.bold14black),
                        ],
                      ),
                      Image.asset(AppAssets.mostRecently),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  SizedBox(width: width * 0.02),
              itemCount: 10,
            ),
          ),
          SizedBox(height: height * 0.01),
          Text('Suras List', style: AppStyles.bold16White),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      SuraDetailsScreen1.routeName,
                      arguments: index,
                    );
                  },
                  child: SuraItem(index: index),
                );
              },
              separatorBuilder: (context, index) => Divider(
                color: AppColor.whiteColor,
                thickness: 2,
                indent: width * 0.1,
                endIndent: width * 0.05,
              ),
              itemCount: 114,
            ),
          ),
        ],
      ),
    );
  }
}
