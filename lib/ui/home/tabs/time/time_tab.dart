import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/ui/home/tabs/time/azkar_item.dart';
import 'package:islami_app/ui/home/tabs/time/cubit/time_states.dart';
import 'package:islami_app/ui/home/tabs/time/cubit/time_view_model.dart';
import 'package:islami_app/ui/home/tabs/time/slider_item.dart';
import 'package:islami_app/util/app_assets.dart';
import 'package:islami_app/util/app_color.dart';
import 'package:islami_app/util/app_styles.dart';
import 'package:islami_app/util/date_formatter.dart';

class TimeTab extends StatefulWidget {
  const TimeTab({super.key});

  @override
  State<TimeTab> createState() => _TimeTabState();
}

class _TimeTabState extends State<TimeTab> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final viewModel = BlocProvider.of<TimeViewModel>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<TimeViewModel, TimeStates>(
            bloc: viewModel,
            builder: (context, state) {
              if (state is TimeErrorState) {
                return Center(
                  child: Text(state.error, style: AppStyles.bold20Primary),
                );
              }
              if (state is TimeSuccessState) {
                final data = state.prayerResponseModel;
                Map<String, dynamic> prayerTimes =
                    DateFormatter.sortPrayerTimes(data.data!.timings!.toJson());

                return Container(
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
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                DateFormatter.formateDate(
                                  data.data!.date!.gregorian!,
                                ),
                                style: AppStyles.bold16White,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              width: width * 0.06,
                              height: height * 0.04,
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40.0),
                                ),
                              ),
                            ),

                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.only(top: height * 0.01),
                                decoration: BoxDecoration(
                                  color: AppColor.primaryColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40.0),
                                    topRight: Radius.circular(40.0),
                                  ),
                                ),
                                child: Text(
                                  "Pray Time\n${data.data!.date!.gregorian!.weekday!.en}",
                                  style: AppStyles.bold20Black,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Container(
                              width: width * 0.06,
                              height: height * 0.04,
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40.0),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                DateFormatter.formateDate(
                                  data.data!.date!.hijri!,
                                ),
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
                              child: CarouselSlider.builder(
                                itemCount: prayerTimes.length,
                                itemBuilder: (context, index, realIndex) =>
                                    SliderItem(
                                      name: prayerTimes.keys.elementAt(index),
                                      time: prayerTimes.values.elementAt(index),
                                    ),
                                options: CarouselOptions(
                                  height: width * 0.3,
                                  enlargeCenterPage: true,
                                  enableInfiniteScroll: true,
                                  viewportFraction: 0.35,
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.06,
                                vertical: height * 0.01,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: width * 0.1),
                                  Text(
                                    "Next Pray - ${DateFormatter.getNextPrayerCountDown(prayerTimes).keys.first}\n${DateFormatter.getNextPrayerCountDown(prayerTimes).values.first.inHours} h : ${DateFormatter.getNextPrayerCountDown(prayerTimes).values.first.inMinutes.remainder(60)} min",
                                    style: AppStyles.bold16Black,
                                    textAlign: TextAlign.center,
                                  ),
                                  Icon(
                                    Icons.volume_up,
                                    color: AppColor.blackColor,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
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
