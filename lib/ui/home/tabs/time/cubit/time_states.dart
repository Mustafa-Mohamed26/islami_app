import 'package:islami_app/model/prayer_response_model.dart';
import 'package:islami_app/util/date_formatter.dart';

/// Base state for the prayer-time cubit.
abstract class TimeStates {
  const TimeStates();
}

/// Emitted before any network call has started.
class TimeInitialState extends TimeStates {
  const TimeInitialState();
}

/// Emitted while the API request is in flight.
class TimeLoadingState extends TimeStates {
  const TimeLoadingState();
}

/// Emitted when the API returns an error or null response.
class TimeErrorState extends TimeStates {
  final String error;
  const TimeErrorState(this.error);
}

/// Emitted once the data has loaded **and** every second afterwards so the
/// "next prayer" countdown always shows a fresh value.
///
/// All display-ready variables are pre-computed here so [TimeTab] contains
/// zero business logic — it only reads from the state.
class TimeSuccessState extends TimeStates {
  // Raw model kept for any deep access if needed.
  final PrayerResponseModel prayerResponseModel;

  // Pre-computed prayer times map (sorted by next upcoming prayer).
  final Map<String, dynamic> prayerTimes;

  // Date display strings.
  final String gregorianDate;
  final String hijriDate;
  final String weekday;

  // Next-prayer countdown fields (updated every second by the cubit timer).
  final String nextPrayerName;
  final String countdownHours;
  final String countdownMinutes;
  final String countdownSeconds;

  // Timestamp that changes each tick — tells BlocBuilder to rebuild.
  final DateTime lastUpdated;

  TimeSuccessState(this.prayerResponseModel)
    : prayerTimes = DateFormatter.sortPrayerTimes(
        prayerResponseModel.data!.timings!.toJson(),
      ),
      gregorianDate = DateFormatter.formateDate(
        prayerResponseModel.data!.date!.gregorian!,
      ),
      hijriDate = DateFormatter.formateDate(
        prayerResponseModel.data!.date!.hijri!,
      ),
      weekday = prayerResponseModel.data!.date!.gregorian!.weekday!.en ?? '',
      nextPrayerName = DateFormatter.getNextPrayer(
        DateFormatter.sortPrayerTimes(
          prayerResponseModel.data!.timings!.toJson(),
        ),
      ).key,
      countdownHours = _pad(
        DateFormatter.getNextPrayer(
          DateFormatter.sortPrayerTimes(
            prayerResponseModel.data!.timings!.toJson(),
          ),
        ).value.inHours,
      ),
      countdownMinutes = _pad(
        DateFormatter.getNextPrayer(
          DateFormatter.sortPrayerTimes(
            prayerResponseModel.data!.timings!.toJson(),
          ),
        ).value.inMinutes.remainder(60),
      ),
      countdownSeconds = _pad(
        DateFormatter.getNextPrayer(
          DateFormatter.sortPrayerTimes(
            prayerResponseModel.data!.timings!.toJson(),
          ),
        ).value.inSeconds.remainder(60),
      ),
      lastUpdated = DateTime.now();

  static String _pad(int n) => n.toString().padLeft(2, '0');
}
