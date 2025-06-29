import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:islami_app/model/time_model.dart';
import 'package:islami_app/ui/home/tabs/time/azkar_item.dart';
import 'package:islami_app/ui/home/tabs/time/slider_item.dart';
import 'package:islami_app/util/app_assets.dart';
import 'package:islami_app/util/app_color.dart';
import 'package:islami_app/util/app_styles.dart';

class TimeTab extends StatelessWidget {
  const TimeTab({super.key});

  static const List<TimeModel> prayerTimes = [
    TimeModel(name: "Fajr", time: "04:04", period: "AM"),
    TimeModel(name: "Dhuhr", time: "01:01", period: "PM"),
    TimeModel(name: "ASR", time: "04:38", period: "PM"),
    TimeModel(name: "Maghrib", time: "07:57", period: "PM"),
    TimeModel(name: "Isha", time: "09:15", period: "PM"),
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColor.brown,
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "16 jul,\n2025",
                          style: AppStyles.bold16White,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.only(top: height * 0.01),
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          child: Text(
                            "Pray Time\nTuesday",
                            style: AppStyles.bold20Black,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "09 Muh,\n1446",
                          style: AppStyles.bold16White,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.06,
                          vertical: height * 0.013,
                        ),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: width * 0.3,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: true,
                            viewportFraction: 0.35,
                          ),
                          items: prayerTimes.map((prayer) {
                            return Builder(
                              builder: (BuildContext context) {
                                return SliderItem(prayer: prayer);
                              },
                            );
                          }).toList(),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.06,
                          vertical: height * 0.01,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: width * 0.1),
                            Text(
                              "Next Pray - 02:32",
                              style: AppStyles.bold16Black,
                              textAlign: TextAlign.center,
                            ),
                            Icon(Icons.volume_up, color: AppColor.blackColor),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.02),
          Text(
            "Azkar",
            style: AppStyles.bold16White,
            textAlign: TextAlign.start,
          ),
          SizedBox(height: height * 0.02),
          Row(
            children: [
              AzkarItem(image: AppAssets.evening, title: "Evening Azkar"),
              SizedBox(width: width * 0.04),
              AzkarItem(image: AppAssets.morning, title: "Morning Azkar"),
            ],
          ),
        ],
      ),
    );
  }
}
