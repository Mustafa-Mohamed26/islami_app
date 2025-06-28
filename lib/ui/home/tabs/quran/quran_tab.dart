import 'package:flutter/material.dart';
import 'package:islami_app/ui/home/tabs/quran/details/sura_details_screen_1.dart';
import 'package:islami_app/ui/home/tabs/quran/most_recent_widget.dart';
import 'package:islami_app/ui/home/tabs/quran/quran_resources.dart';
import 'package:islami_app/ui/home/tabs/quran/sura_item.dart';
import 'package:islami_app/util/app_assets.dart';
import 'package:islami_app/util/app_color.dart';
import 'package:islami_app/util/app_styles.dart';
import 'package:islami_app/util/shared_prefs.dart';

//TODO: search on flutter keys
class QuranTab extends StatefulWidget {
  /// 114 suras in Quran
  QuranTab({super.key});
  @override
  State<QuranTab> createState() => _QuranTabState();
}

class _QuranTabState extends State<QuranTab> {
  List<int> filterList = List.generate(114, (int index) => index);
  void searchByNewText(String newText) {
    List<int> filterSearchList = [];
    for (int i = 0; i < QuranResources.englishQuranList.length; i++) {
      if (QuranResources.englishQuranList[i].toLowerCase().contains(
        newText.toLowerCase(),
      )) {
        filterSearchList.add(i);
      }
      if (QuranResources.arabicQuranList[i].toLowerCase().contains(
        newText.toLowerCase(),
      )) {
        filterSearchList.add(i);
      }
    }
    filterList = filterSearchList;

    if (newText.isEmpty) {
      filterList = List.generate(114, (int index) => index);
    }
    setState(() {});
  }

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
          // Search Field Section
          TextField(
            onChanged: (newText) {
              searchByNewText(newText);
            },
            style: AppStyles.bold16White,
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
          // Most Recently Read Section
          MostRecentWidget(),
          SizedBox(height: height * 0.01),
          // Suras List Section
          Text('Suras List', style: AppStyles.bold16White),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    // Save the last sura index to shared preferences
                    saveNewSuraList(filterList[index]);
                    // Navigate to Sura Details Screen with the selected sura index
                    Navigator.of(context).pushNamed(
                      SuraDetailsScreen1.routeName,
                      arguments: filterList[index],
                    );
                  },
                  child: SuraItem(index: filterList[index]),
                );
              },
              separatorBuilder: (context, index) => Divider(
                color: AppColor.whiteColor,
                thickness: 2,
                indent: width * 0.1,
                endIndent: width * 0.05,
              ),
              itemCount: filterList.length,
            ),
          ),
        ],
      ),
    );
  }
}
