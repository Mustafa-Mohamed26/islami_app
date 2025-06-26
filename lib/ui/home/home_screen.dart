import 'package:flutter/material.dart';
import 'package:islami_app/ui/home/tabs/hadeth/hadeth_tab.dart';
import 'package:islami_app/ui/home/tabs/quran/quran_tab.dart';
import 'package:islami_app/ui/home/tabs/radio/radio_tab.dart';
import 'package:islami_app/ui/home/tabs/sebha/sebha_tab.dart';
import 'package:islami_app/ui/home/tabs/time/time_tab.dart';
import 'package:islami_app/util/app_assets.dart';
import 'package:islami_app/util/app_color.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<String> backgroundImages = [
    AppAssets.quranBg,
    AppAssets.hadethBg,
    AppAssets.sebhaBg,
    AppAssets.radioBg,
    AppAssets.timeBg,
  ];

  List<Widget> tabs = [
    QuranTab(),
    HadethTab(),
    SebhaTab(),
    RadioTab(),
    TimeTab(),
  ];

  Widget builtBottomNavigationBar({
    required int index,
    required String imageName,
  }) {
    return selectedIndex == index
        ? Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(66),
              color: AppColor.blackBgColor,
            ),
            child: ImageIcon(AssetImage(imageName)),
          )
        : ImageIcon(AssetImage(imageName));
  }

  String getBackgroundImage() {
    switch (selectedIndex) {
      case 0:
        return AppAssets.quranBg;
      case 1:
        return AppAssets.hadethBg;
      case 2:
        return AppAssets.sebhaBg;
      case 3:
        return AppAssets.radioBg;
      case 4:
        return AppAssets.timeBg;
      default:
        return AppAssets.quranBg; // Default background
    }
  }

  @override
  Widget build(BuildContext context) {
    // const => compile time full immutable
    // final => run time half immutable
    // const int x = 10;
    // final int y;

    // hot restart => rebuild the whole app
    // hot reload => rebuild the widget tree

    return Stack(
      children: [
        Image.asset(
          getBackgroundImage(),
          //backgroundImages[selectedIndex],
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ),
        Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppAssets.logo),
              Expanded(child: tabs[selectedIndex]),
            ],
          ),
          bottomNavigationBar: Theme(
            data: Theme.of(
              context,
            ).copyWith(canvasColor: AppColor.primaryColor),
            child: BottomNavigationBar(
              // type: BottomNavigationBarType.fixed,
              // backgroundColor: AppColor.primaryColor,
              currentIndex: selectedIndex,
              onTap: (index) {
                selectedIndex = index;
                setState(() {});
              },
              items: [
                BottomNavigationBarItem(
                  icon: builtBottomNavigationBar(
                    index: 0,
                    imageName: AppAssets.iconQuran,
                  ),
                  label: 'Quran',
                ),
                BottomNavigationBarItem(
                  icon: builtBottomNavigationBar(
                    index: 1,
                    imageName: AppAssets.iconHadeth,
                  ),
                  label: 'Hadeth',
                ),
                BottomNavigationBarItem(
                  icon: builtBottomNavigationBar(
                    index: 2,
                    imageName: AppAssets.iconSebha,
                  ),
                  label: 'Sebha',
                ),
                BottomNavigationBarItem(
                  icon: builtBottomNavigationBar(
                    index: 3,
                    imageName: AppAssets.iconRadio,
                  ),
                  label: 'Radio',
                ),
                BottomNavigationBarItem(
                  icon: builtBottomNavigationBar(
                    index: 4,
                    imageName: AppAssets.iconTime,
                  ),
                  label: 'Time',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
