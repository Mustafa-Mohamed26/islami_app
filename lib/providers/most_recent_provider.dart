import 'package:flutter/material.dart';
import 'package:islami_app/util/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

// data change in more than one widget
// function that notifies listeners when data changes
// ChangeNotifier is a class that provides change notification to its listeners
class MostRecentProvider extends ChangeNotifier {
  // List to hold the most recent sura indices
  // This list will be used to store the indices of the most recently read suras
  List<int> mostRecentList = [];

  void getMostRecentSuraList() async {
  // Get the instance of SharedPreferences
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  // Retrieve the existing list or initialize it if it doesn't exist
  List<String> mostRecentIndicesListAsString = prefs.getStringList(SharedPrefsKey.mostRecentKey) ?? [];
  // Convert the list of strings to a list of integers
  mostRecentList = mostRecentIndicesListAsString.map((e) => int.parse(e)).toList();
  // Return the list of most recent sura indices
  //return mostRecentList; // Return the list as is, or you can reverse it if needed
  //return mostRecentIndicesAsInt.reversed.toList(); // Return the list in reverse order to show the most recent first

  notifyListeners(); // Notify listeners that the data has changed
  }
}
