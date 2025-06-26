import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_app/ui/home/tabs/quran/quran_resources.dart';
import 'package:islami_app/ui/home/tabs/quran/sura_content.dart';
import 'package:islami_app/util/app_assets.dart';
import 'package:islami_app/util/app_color.dart';
import 'package:islami_app/util/app_styles.dart';

class SuraDetailsScreen extends StatefulWidget {
  static const String routeName = 'suraDetails';

  SuraDetailsScreen({super.key});

  @override
  State<SuraDetailsScreen> createState() => _SuraDetailsScreenState();
}

class _SuraDetailsScreenState extends State<SuraDetailsScreen> {
  //List<String> verses = [];
  String suraContent = '';

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
      lines[i]+= '[${i+1}]';
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

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    int index = ModalRoute.of(context)?.settings.arguments as int;
    if (suraContent.isEmpty) {
      loadSuraFile(index);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          QuranResources.englishQuranList[index],
          style: AppStyles.bold20Primary,
        ),
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
              child: suraContent.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      ),
                    )
                  : SingleChildScrollView(child: SuraContent(suraContent: suraContent))
            ),
             Image.asset(AppAssets.mousqueBg)
          ],
         
        ),
      ),
    );
  }
}
