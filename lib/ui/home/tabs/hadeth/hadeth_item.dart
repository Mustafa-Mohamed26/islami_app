import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_app/model/hadeth_model.dart';
import 'package:islami_app/util/app_assets.dart';
import 'package:islami_app/util/app_color.dart';
import 'package:islami_app/util/app_styles.dart';

class HadethItem extends StatefulWidget {
  int index;

  HadethItem({super.key, required this.index});

  @override
  State<HadethItem> createState() => _HadethItemState();
}

class _HadethItemState extends State<HadethItem> {
  HadethModel? hadethModel;

  void loadHadethFile(int index) async {
    // Load the hadeth file from assets
    String fileContent = await rootBundle.loadString(
      'assets/Hadeeth/h$index.txt',
    );
    // Process the file content
    // For example, you can split the content into lines or extract specific information
    int fileLinesIndex = fileContent.indexOf('\n');
    String title = fileContent.substring(0, fileLinesIndex);
    String content = fileContent.substring(fileLinesIndex + 1);
    // List<String> hadethLines = fileContent.split('\n');
    // for(int i = 0; i < hadethLines.length; i++) {
    //   String title = hadethLines[0];
    //   hadethLines.removeAt(0);
    // }
    hadethModel = HadethModel(title: title, content: content);
    // You can now use the hadethModel to display the data in your widget
    await Future.delayed(Duration(seconds: 1)); // Simulate a delay for loading
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadHadethFile(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    var hight = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: AppColor.primaryColor,

        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(AppAssets.hadethCardBackground),
          fit: BoxFit.fill,
        ),
      ),
      child: hadethModel == null
          ? Center(child: CircularProgressIndicator(color: AppColor.blackColor))
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.02,
                    vertical: hight * 0.01,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(AppAssets.corner2, width: width * 0.20),
                      Expanded(
                        child: Text(
                          hadethModel?.title ?? "",
                          style: AppStyles.bold24Black,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Image.asset(AppAssets.corner1, width: width * 0.20),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric( horizontal: 16.0),
                      child: Text(
                        hadethModel?.content ?? "",
                        style: AppStyles.bold16Black,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Image.asset(AppAssets.hadethMosque),
              ],
            ),
    );
  }
}

class AppStyle {}
