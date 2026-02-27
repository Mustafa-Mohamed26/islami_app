import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/ui/home/tabs/time/azkar_item.dart';
import 'package:islami_app/ui/home/tabs/time/azkar_screen.dart';
import 'package:islami_app/ui/home/tabs/time/cubit/time_states.dart';
import 'package:islami_app/ui/home/tabs/time/cubit/time_view_model.dart';
import 'package:islami_app/ui/home/tabs/time/slider_item.dart';
import 'package:islami_app/util/app_assets.dart';
import 'package:islami_app/util/app_color.dart';
import 'package:islami_app/util/app_styles.dart';

/// Entry-point widget for the "Time" tab.
///
/// Purely presentational — all data and business logic live in
/// [TimeViewModel] and [TimeSuccessState]. Methods only use [state.*] fields.
class TimeTab extends StatelessWidget {
  const TimeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Prayer-time card — reactive to cubit state
          BlocBuilder<TimeViewModel, TimeStates>(
            builder: (context, state) {
              if (state is TimeErrorState) {
                return _buildError(state.error);
              }
              if (state is TimeSuccessState) {
                return _buildPrayerCard(state, size);
              }
              return _buildLoading();
            },
          ),

          SizedBox(height: size.height * 0.02),

          // Azkar section
          Text('Azkar', style: AppStyles.bold16White),
          SizedBox(height: size.height * 0.02),
          _buildAzkarRow(context, size),
        ],
      ),
    );
  }

  // ── State views ──────────────────────────────────────────────────────────────

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  Widget _buildError(String message) =>
      Center(child: Text(message, style: AppStyles.bold20Primary));

  // ── Prayer card ──────────────────────────────────────────────────────────────

  Widget _buildPrayerCard(TimeSuccessState state, Size size) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.brown,
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Column(
        children: [
          _buildDateHeader(state, size),
          _buildPrayerTimesBody(state, size),
        ],
      ),
    );
  }

  // ── Date header ──────────────────────────────────────────────────────────────

  Widget _buildDateHeader(TimeSuccessState state, Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Gregorian date  — read directly from state
          Expanded(
            child: Text(
              state.gregorianDate,
              style: AppStyles.bold16White,
              textAlign: TextAlign.left,
            ),
          ),

          _buildCornerBox(size, rightRadius: false),

          // Centre "Pray Time / weekday" tab
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(top: size.height * 0.01),
              decoration: const BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: Text(
                'Pray Time\n${state.weekday}',
                style: AppStyles.bold20Black,
                textAlign: TextAlign.center,
              ),
            ),
          ),

          _buildCornerBox(size, rightRadius: true),

          // Hijri date — read directly from state
          Expanded(
            child: Text(
              state.hijriDate,
              style: AppStyles.bold16White,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  /// Small decorative corner box sitting beside the centre tab.
  Widget _buildCornerBox(Size size, {required bool rightRadius}) {
    return Container(
      width: size.width * 0.06,
      height: size.height * 0.04,
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: rightRadius ? Radius.zero : const Radius.circular(40.0),
          topRight: rightRadius ? const Radius.circular(40.0) : Radius.zero,
        ),
      ),
    );
  }

  // ── Prayer times body (carousel + countdown) ─────────────────────────────────

  Widget _buildPrayerTimesBody(TimeSuccessState state, Size size) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Column(
        children: [
          // Carousel — uses state.prayerTimes directly
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.06,
              vertical: size.height * 0.013,
            ),
            child: CarouselSlider.builder(
              itemCount: state.prayerTimes.length,
              itemBuilder: (_, index, __) => SliderItem(
                name: state.prayerTimes.keys.elementAt(index),
                time: state.prayerTimes.values.elementAt(index) as String,
              ),
              options: CarouselOptions(
                height: size.width * 0.3,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                viewportFraction: 0.35,
              ),
            ),
          ),

          // Live next-prayer countdown — rebuilds every second via cubit timer
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.06,
              vertical: size.height * 0.01,
            ),
            child: _buildNextPrayerRow(state, size),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // ── Next-prayer countdown row ────────────────────────────────────────────────

  /// Reads pre-formatted countdown strings directly from [state].
  /// Rebuilds every second because [TimeViewModel] re-emits [TimeSuccessState]
  /// on a 1-second periodic timer.
  Widget _buildNextPrayerRow(TimeSuccessState state, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Next Pray — ${state.nextPrayerName}\n'
          '${state.countdownHours} h : '
          '${state.countdownMinutes} min : '
          '${state.countdownSeconds} sec',
          style: AppStyles.bold16Black,
          textAlign: TextAlign.center,
        ),
        
      ],
    );
  }

  // ── Azkar row ────────────────────────────────────────────────────────────────

  Widget _buildAzkarRow(BuildContext context, Size size) {
    return Row(
      children: [
        AzkarItem(
          image: AppAssets.evening,
          title: 'Evening Azkar',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AzkarScreen(type: 'evening'),
            ),
          ),
        ),
        SizedBox(width: size.width * 0.04),
        AzkarItem(
          image: AppAssets.morning,
          title: 'Morning Azkar',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AzkarScreen(type: 'morning'),
            ),
          ),
        ),
      ],
    );
  }
}
