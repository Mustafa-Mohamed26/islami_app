//save last sura => write data to shared preferences
//get last sura => read data from shared preferences


import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsKey {
  static const String mostRecentKey = 'most_Recent';
}

void saveNewSuraList(int newSuraIndex) async {
  // Get the instance of SharedPreferences
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  // Retrieve the existing list or initialize it if it doesn't exist
  // If the list doesn't exist, it will return an empty list
  List<String> mostRecentIndicesList = prefs.getStringList(SharedPrefsKey.mostRecentKey) ?? [];
  // Check if the new index already exists in the list
  if (mostRecentIndicesList.contains('$newSuraIndex')) {
    // If it exists, remove it to avoid duplicates
    mostRecentIndicesList.remove('$newSuraIndex');
    mostRecentIndicesList.insert(0, '$newSuraIndex'); 
  }else{
  // If it doesn't exist, add the new index to the list
  mostRecentIndicesList.insert(0, '$newSuraIndex'); // Insert the new index at the beginning
  //mostRecentIndicesList.add('$newSuraIndex');
  }
  // Limit the list to the last 5 sura indices
  if (mostRecentIndicesList.length > 5) {
    //mostRecentIndicesList.removeLast();
    mostRecentIndicesList = mostRecentIndicesList.sublist(0, 5); // Keep only the first 5 elements
  }
  
  await prefs.setStringList(SharedPrefsKey.mostRecentKey, mostRecentIndicesList);
}

