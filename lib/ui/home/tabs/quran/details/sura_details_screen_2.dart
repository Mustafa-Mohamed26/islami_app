import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_app/ui/home/tabs/quran/quran_resources.dart';
import 'package:islami_app/ui/home/tabs/quran/details/sura_content.dart';
import 'package:islami_app/util/app_assets.dart';
import 'package:islami_app/util/app_color.dart';
import 'package:islami_app/util/app_styles.dart';

class SuraDetailsScreen2 extends StatefulWidget {
  static const String routeName = 'suraDetails';

  const SuraDetailsScreen2({super.key});

  @override
  State<SuraDetailsScreen2> createState() => _SuraDetailsScreenState();
}

class _SuraDetailsScreenState extends State<SuraDetailsScreen2> {
  //List<String> verses = [];
  String suraContent = ''; // Variable to hold the content of the Sura

  // Function to load the Sura file and extract verses
  void loadSuraFile(int index) async {
    // Load the sura file content from assets
    // Assuming the files are named as 1.txt, 2.txt, ..., n.txt
    // where n is the number of suras
    // You can adjust the path according to your assets structure
    // async and await are used to handle asynchronous operations
    String fileContent = await rootBundle.loadString(
      'assets/files/${index + 1}.txt',
    );
    List<String> lines = fileContent.split('\n');
    for (var i = 0; i < lines.length; i++) {
      lines[i] += ' [${i + 1}] ';
    }
    suraContent = lines.join();
    //verses = lines;
    Future.delayed(const Duration(seconds: 1), () {
      // This delay is to simulate loading time
      // You can remove it if you want to load immediately
      setState(() {
        // Update the state to reflect the loaded verses
        // This will trigger a rebuild of the widget with the new verses
      });
    });
  }

  // Build the SuraDetailsScreen widget
  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context)?.settings.arguments as int;
    if (suraContent.isEmpty) {
      loadSuraFile(index);
    }
    return Scaffold(
      appBar: _buildAppBar(index),
      body: Container(
        color: AppColor.blackBgColor,
        child: Column(
          children: [
            _buildSuraHeader(index),
            _buildSuraContent(),
            _buildMosqueBackground(),
          ],
        ),
      ),
    );
  }

  // Build the AppBar for the SuraDetailsScreen
  PreferredSizeWidget _buildAppBar(int index) {
    return AppBar(
      title: Text(
        QuranResources.englishQuranList[index],
        style: AppStyles.bold20Primary,
      ),
    );
  }

  // Build the header for the SuraDetailsScreen
  Widget _buildSuraHeader(int index) {
    return Padding(
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
    );
  }

  // Build the content for the SuraDetailsScreen
  Widget _buildSuraContent() {
    return Expanded(
      child: suraContent.isEmpty
          ? Center(
              child: CircularProgressIndicator(color: AppColor.primaryColor),
            )
          : SingleChildScrollView(child: SuraContent(suraContent: suraContent)),
    );
  }

  // Build the mosque background for the SuraDetailsScreen
  Widget _buildMosqueBackground() {
    return Image.asset(AppAssets.mousqueBg);
  }
}
