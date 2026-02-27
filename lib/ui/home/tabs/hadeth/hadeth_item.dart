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

  // Function to load the hadeth file and extract title and content
  void loadHadethFile(int index) async {
    // Load the hadeth file from assets
    String fileContent = await rootBundle.loadString(
      'assets/Hadeeth/h$index.txt',
    );
    // Process the file content
    // Find the first newline character to separate title and content efficiently
    int fileLinesIndex = fileContent.indexOf('\n');
    String title = fileContent.substring(0, fileLinesIndex).trim();
    String content = fileContent.substring(fileLinesIndex + 1).trim();

    hadethModel = HadethModel(title: title, content: content);

    // Update state only if the widget is still mounted
    if (mounted) {
      setState(() {});
    }
  }

  // Load the hadeth file when the widget is initialized
  @override
  void initState() {
    super.initState();
    loadHadethFile(widget.index);
  }

  // Build the HadethItem widget
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
                _buildHeader(width, hight),
                _buildContent(),
                _buildMosqueImage(),
              ],
            ),
    );
  }

  // Build the header of the HadethItem
  Widget _buildHeader(double width, double hight) {
    return Padding(
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
    );
  }

  // Build the content of the HadethItem
  Widget _buildContent() {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            hadethModel?.content ?? "",
            style: AppStyles.bold16Black,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  // Build the mosque image at the bottom of the HadethItem
  Widget _buildMosqueImage() {
    return Image.asset(AppAssets.hadethMosque);
  }
}
