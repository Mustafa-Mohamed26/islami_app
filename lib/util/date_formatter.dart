import 'package:intl/intl.dart';
import 'package:islami_app/model/prayer_response_model.dart';

mixin Formattable {
  String? get day;
  Month? get month;
  String? get year;
}

class DateFormatter {
  static DateTime _now = DateTime.now();
  static String formateDate(Formattable formattableMixin) {
    return '${formattableMixin.day} ${formattableMixin.month!.en!.substring(0, 3)}\n ${formattableMixin.year}';
  }

  static Map<String, dynamic> sortPrayerTimes(
    Map<String, dynamic> prayerTimes,
  ) {
    var sortedEntries = prayerTimes.entries.toList()
      ..sort((a, b) {
        // Parse the time strings into DateTime objects
        DateTime timeA = DateFormat("HH:mm").parse(a.value);
        DateTime timeB = DateFormat("HH:mm").parse(b.value);

        // Compare the DateTime objects
        DateTime dateTimeA = DateTime(
          _now.year,
          _now.month,
          _now.day,
          timeA.hour,
          timeA.minute,
        );

        // Compare the DateTime objects
        DateTime dateTimeB = DateTime(
          _now.year,
          _now.month,
          _now.day,
          timeB.hour,
          timeB.minute,
        );

        // Check if the DateTime objects are before or at the same moment as now
        if (dateTimeA.isBefore(_now) || dateTimeA.isAtSameMomentAs(_now)) {
          dateTimeA = dateTimeA.add(Duration(days: 1));
        }
        if (dateTimeB.isBefore(_now) || dateTimeB.isAtSameMomentAs(_now)) {
          dateTimeB = dateTimeB.add(Duration(days: 1));
        }

        return dateTimeA.compareTo(dateTimeB);
      });

    return Map<String, dynamic>.fromEntries(sortedEntries);
  }

  static Map<String, Duration> getNextPrayerCountDown(
    Map<String, dynamic> prayerTimes,
  ) {
    // Get the current time
    Map<String, Duration> timeDifference = {};

    // Iterate through the prayer times and calculate the difference from now
    prayerTimes.forEach((prayName, prayTimeString) {
      DateTime prayerTime = DateFormat("HH:mm").parse(prayTimeString);
      DateTime prayerDateTime = DateTime(
        _now.year,
        _now.month,
        _now.day,
        prayerTime.hour,
        prayerTime.minute,
      );

      // If the prayer time is before or at the same moment as now, add one day to it
      if (prayerDateTime.isBefore(_now) ||
          prayerDateTime.isAtSameMomentAs(_now)) {
        prayerDateTime = prayerDateTime.add(Duration(days: 1));
      }

      // Calculate the difference between the prayer time and now
      Duration difference = prayerDateTime.difference(_now);
      timeDifference[prayName] = difference;
    });

    return timeDifference;
  }
}

class TimeConverter {
  static String to12Hour(String time) {
    DateTime dateTime = DateFormat("HH:mm").parse(time);
    return DateFormat("hh:mm\n a").format(dateTime);
  }
}
