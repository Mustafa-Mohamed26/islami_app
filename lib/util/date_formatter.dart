import 'package:intl/intl.dart';
import 'package:islami_app/model/prayer_response_model.dart';

/// Mixin applied to Gregorian and Hijri date models that expose
/// day / month / year fields for [DateFormatter.formateDate].
mixin Formattable {
  String? get day;
  Month? get month;
  String? get year;
}

/// Utility class for formatting dates and computing prayer-time countdowns.
///
/// All methods use [DateTime.now()] at call-time so countdowns are always
/// accurate (avoids the stale-static-field bug).
class DateFormatter {
  DateFormatter._(); // non-instantiable

  /// Returns a two-line string: "15 Feb\n 2026" for any [Formattable] date.
  static String formateDate(Formattable date) {
    return '${date.day} ${date.month!.en!.substring(0, 3)}\n ${date.year}';
  }

  /// Sorts prayer-time entries chronologically relative to *now*, so the next
  /// upcoming prayer always appears first in the carousel.
  static Map<String, dynamic> sortPrayerTimes(
    Map<String, dynamic> prayerTimes,
  ) {
    final now = DateTime.now();
    final sorted = prayerTimes.entries.toList()
      ..sort((a, b) {
        final timeA = _toTodayDateTime(a.value as String, now);
        final timeB = _toTodayDateTime(b.value as String, now);
        final adjA = timeA.isBefore(now)
            ? timeA.add(const Duration(days: 1))
            : timeA;
        final adjB = timeB.isBefore(now)
            ? timeB.add(const Duration(days: 1))
            : timeB;
        return adjA.compareTo(adjB);
      });
    return Map<String, dynamic>.fromEntries(sorted);
  }

  /// Returns the name and remaining [Duration] for the next upcoming prayer.
  ///
  /// Returns the first entry of the sorted map, which is always the soonest
  /// upcoming prayer because [sortPrayerTimes] already orders them correctly.
  static MapEntry<String, Duration> getNextPrayer(
    Map<String, dynamic> prayerTimes,
  ) {
    final now = DateTime.now();
    final sorted = sortPrayerTimes(prayerTimes);
    final entry = sorted.entries.first;
    final prayerDt = _toTodayDateTime(entry.value as String, now);
    final adjusted = prayerDt.isBefore(now)
        ? prayerDt.add(const Duration(days: 1))
        : prayerDt;
    return MapEntry(entry.key, adjusted.difference(now));
  }

  // ── Private ─────────────────────────────────────────────────────────────────

  static DateTime _toTodayDateTime(String timeStr, DateTime now) {
    final parsed = DateFormat('HH:mm').parse(timeStr);
    return DateTime(now.year, now.month, now.day, parsed.hour, parsed.minute);
  }
}

/// Converts 24-hour time strings to a 12-hour display format.
class TimeConverter {
  TimeConverter._(); // non-instantiable

  static String to12Hour(String time) {
    final dt = DateFormat('HH:mm').parse(time);
    return DateFormat('hh:mm\n a').format(dt);
  }
}
