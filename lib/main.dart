import 'package:flutter/material.dart';
import 'package:islami_app/providers/most_recent_provider.dart';
import 'package:islami_app/ui/home/home_screen.dart';
import 'package:islami_app/ui/home/tabs/quran/details/sura_details_screen_2.dart';
import 'package:islami_app/ui/home/tabs/quran/details/sura_details_screen_1.dart';
import 'package:islami_app/ui/onboarding/onboarding_screen.dart';
import 'package:islami_app/util/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final seenOnboarding = prefs.getBool('seenOnboarding') ?? false;

  runApp(
    ChangeNotifierProvider(
      create: (context) => MostRecentProvider(),
      child: MyApp(showOnboarding: !seenOnboarding),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool showOnboarding;
  const MyApp({super.key, required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Islami App',
      debugShowCheckedModeBanner: false,
      initialRoute: showOnboarding
          ? OnboardingScreen.routeName
          : HomeScreen.routeName,
      routes: {
        OnboardingScreen.routeName: (context) => OnboardingScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        SuraDetailsScreen1.routeName: (context) => SuraDetailsScreen1(),
        SuraDetailsScreen2.routeName: (context) => SuraDetailsScreen2(),
      },
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark, // Use dark theme by default
    );
  }
}
