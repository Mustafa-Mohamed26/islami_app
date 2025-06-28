import 'package:flutter/material.dart';
import 'package:islami_app/providers/most_recent_provider.dart';
import 'package:islami_app/ui/home/tabs/quran/quran_resources.dart';
import 'package:islami_app/util/app_assets.dart';
import 'package:islami_app/util/app_color.dart';
import 'package:islami_app/util/app_styles.dart';
import 'package:islami_app/util/shared_prefs.dart';
import 'package:provider/provider.dart';

class MostRecentWidget extends StatefulWidget {
  MostRecentWidget({super.key});

  @override
  State<MostRecentWidget> createState() => _MostRecentWidgetState();
}

class _MostRecentWidgetState extends State<MostRecentWidget> {
  late MostRecentProvider mostRecentProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Load the most recent sura list after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mostRecentProvider.getMostRecentSuraList();
    });
    
  }

  @override
  Widget build(BuildContext context) {
    mostRecentProvider = Provider.of<MostRecentProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Visibility(
      visible: mostRecentProvider.mostRecentList.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
                          Text(
                            QuranResources.englishQuranList[mostRecentProvider
                                .mostRecentList[index]],
                            style: AppStyles.bold24Black,
                          ),
                          Text(
                            QuranResources.arabicQuranList[mostRecentProvider
                                .mostRecentList[index]],
                            style: AppStyles.bold24Black,
                          ),
                          Text(
                            "${QuranResources.versesNumberList[mostRecentProvider.mostRecentList[index]]} Verses",
                            style: AppStyles.bold14black,
                          ),
                        ],
                      ),
                      Image.asset(AppAssets.mostRecently),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  SizedBox(width: width * 0.02),
              itemCount: mostRecentProvider.mostRecentList.length,
            ),
          ),
        ],
      ),
    );
  }
}
