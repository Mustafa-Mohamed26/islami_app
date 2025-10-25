import 'dart:convert';

import 'package:http/http.dart' as http;
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
      Uri url = Uri.parse('https://www.mp3quran.net/api/v3/reciters?language=ar');
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return RecitersResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }
}
