import 'package:flutter/material.dart';
import 'package:islami_app/providers/most_recent_provider.dart';
import 'package:islami_app/ui/home/tabs/quran/details/sura_details_screen_1.dart';
import 'package:islami_app/ui/home/tabs/quran/quran_resources.dart';
import 'package:islami_app/util/app_assets.dart';
import 'package:islami_app/util/app_color.dart';
import 'package:islami_app/util/app_styles.dart';
import 'package:islami_app/util/shared_prefs.dart';
import 'package:provider/provider.dart';

class MostRecentWidget extends StatefulWidget {
  const MostRecentWidget({super.key});

  @override
  State<MostRecentWidget> createState() => _MostRecentWidgetState();
}

class _MostRecentWidgetState extends State<MostRecentWidget> {
  late MostRecentProvider mostRecentProvider; // Provider to manage the most recent Sura list

  // Initialize the state and load the most recent sura list
  @override
  void initState() {
    super.initState();
    // Load the most recent sura list after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mostRecentProvider.getMostRecentSuraList();
    });
  }

  // Build the widget
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
          _buildHeader(),
          SizedBox(height: height * 0.01),
          _buildRecentList(width, height),
        ],
      ),
    );
  }

  // Build the header for the Most Recent Widget
  Widget _buildHeader() {
    return Text('Most Recently Read', style: AppStyles.bold16White);
  }

  // Build the list of recent Sura items
  Widget _buildRecentList(double width, double height) {
    return SizedBox(
      height: height * 0.16,
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _buildRecentItem(context, index, width);
        },
        separatorBuilder: (context, index) => SizedBox(width: width * 0.02),
        itemCount: mostRecentProvider.mostRecentList.length,
      ),
    );
  }

  // Build each recent item in the list
  Widget _buildRecentItem(BuildContext context, int index, double width) {
    int suraIndex = mostRecentProvider.mostRecentList[index];
    return InkWell(
      onTap: () {
        // Save the last sura index to shared preferences
        saveNewSuraList(suraIndex);
        // Navigate to Sura Details Screen with the selected sura index
        Navigator.of(
          context,
        ).pushNamed(SuraDetailsScreen1.routeName, arguments: suraIndex);
      },
      child: Container(
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
                  QuranResources.englishQuranList[suraIndex],
                  style: AppStyles.bold24Black,
                ),
                Text(
                  QuranResources.arabicQuranList[suraIndex],
                  style: AppStyles.bold24Black,
                ),
                Text(
                  "${QuranResources.versesNumberList[suraIndex]} Verses",
                  style: AppStyles.bold14black,
                ),
              ],
            ),
            Image.asset(AppAssets.mostRecently),
          ],
        ),
      ),
    );
  }
}
