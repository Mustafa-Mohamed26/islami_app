import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:islami_app/model/prayer_response_model.dart';
import 'package:islami_app/model/radio_response.dart';
import 'package:islami_app/model/reciters_response.dart';

class ApiManager {
  // get radio
  static Future<RadioResponse?> getRadio() async {
    Uri url = Uri.parse('https://mp3quran.net/api/v3/radios?language=ar');
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return RadioResponse.fromJson(json);
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<RecitersResponse?> getReciters() async {
    try {
      Uri url = Uri.parse(
        'https://www.mp3quran.net/api/v3/reciters?language=ar',
      );
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return RecitersResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  static Future<PrayerResponseModel?> getPrayingData() async {
    String date = DateFormat("dd-MM-yyyy").format(DateTime.now());

    try {
      Uri url = Uri.parse(
        'https://api.aladhan.com/v1/timingsByCity?date=$date&city=Alexandria&country=Egypt',
      );

      var response = await http.get(url);

      print("Status Code: ${response.statusCode}");
      print("Body: ${response.body}");

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return PrayerResponseModel.fromJson(json);
      } else {
        throw Exception("Failed to load prayer times");
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
