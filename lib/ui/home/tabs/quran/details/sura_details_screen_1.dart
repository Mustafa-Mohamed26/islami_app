import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_app/ui/home/tabs/quran/details/sura_content_item.dart';
import 'package:islami_app/ui/home/tabs/quran/details/sura_details_screen_2.dart';
import 'package:islami_app/ui/home/tabs/quran/quran_resources.dart';
import 'package:islami_app/util/app_assets.dart';
import 'package:islami_app/util/app_color.dart';
import 'package:islami_app/util/app_styles.dart';

class SuraDetailsScreen1 extends StatefulWidget {
  static const String routeName = 'suraDetails1';

  const SuraDetailsScreen1({super.key});

  @override
  State<SuraDetailsScreen1> createState() => _SuraDetailsScreen1State();
}

class _SuraDetailsScreen1State extends State<SuraDetailsScreen1> {
  List<String> verses = [];
  int? selectedIndex;

  void loadSuraFile(int index) async {
    String fileContent = await rootBundle.loadString(
      'assets/files/${index + 1}.txt',
    );
    List<String> lines = fileContent.split('\n');

    verses = lines;
    Future.delayed(const Duration(seconds: 1), () {
      // This delay is to simulate loading time
      // You can remove it if you want to load immediately
      setState(() {
        // Update the state to reflect the loaded verses
        // This will trigger a rebuild of the widget with the new verses
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context)?.settings.arguments as int;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    if (verses.isEmpty) {
      loadSuraFile(index);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          QuranResources.englishQuranList[index],
          style: AppStyles.bold20Primary,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_book, size: 30),
            tooltip: 'Go to Sura Details 2',
            onPressed: () {
              Navigator.pushNamed(
                context,
                SuraDetailsScreen2.routeName,
                arguments: index,
              );
            },
          ),
        ],
      ),
      body: Container(
        color: AppColor.blackBgColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(AppAssets.detailsLeftBg),
                  Text(
                    QuranResources.arabicQuranList[index],
                    style: AppStyles.bold24Primary,
                  ),
                  Image.asset(AppAssets.detailsRightBg),
                ],
              ),
            ),
            Expanded(
              child: verses.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      itemCount: verses.length,
                      itemBuilder: (context, verseIndex) {
                        return SuraContentItem(
                          suraContent: verses[verseIndex],
                          index: verseIndex,
                          isSelected: selectedIndex == verseIndex,
                          onTap: () {
                            setState(() {
                              selectedIndex = verseIndex;
                            });
                          },
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: height * 0.02),
                    ),
            ),
            Image.asset(AppAssets.mousqueBg),
          ],
        ),
      ),
    );
  }
}
