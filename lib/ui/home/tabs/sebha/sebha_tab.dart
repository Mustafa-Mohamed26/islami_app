import 'package:flutter/material.dart';
import 'package:islami_app/util/app_assets.dart';
import 'package:islami_app/util/app_styles.dart';

class SebhaTab extends StatefulWidget {
  const SebhaTab({super.key});

  @override
  State<SebhaTab> createState() => _SebhaTabState();
}

class _SebhaTabState extends State<SebhaTab>
    with SingleTickerProviderStateMixin {
  int counter = 1; // Counter to track the number of taps on the sebha
  int textIndex = 0; // Index to track which tasbeeh text to display
  double turns = 0.0; // Variable to track the rotation of the sebha image
  static const int maxCount = 33; // Maximum count before resetting and changing the tasbeeh text
  static const List<String> tasbeehList = [
    "سبحان الله",
    "الحمد لله",
    "لا إله إلا الله",
    "الله أكبر",
    "لا حول ولا قوة إلا بالله",
  ]; // List of tasbeeh texts to display based on the counter

  late final AnimationController controller; // Controller for the animation
  late final Animation<double> animation; // Animation to handle the rotation of the sebha image

  // Initialize the animation controller and animation
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 1).animate(controller);
  }

  // Dispose the animation controller when the widget is removed from the widget tree
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // Handle the tap on the sebha image, update the counter, text index, and trigger the animation
  void onSebhaTap() async {
    setState(() {
      turns += 1 / maxCount;
      counter++;
      if (counter > maxCount) {
        counter = 1;
        textIndex = (textIndex + 1) % tasbeehList.length;
      }
    });
    await controller.forward(from: 0);
  }

  // Build the SebhaTab widget
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        _buildHeaderTitle(),
        Stack(
          alignment: Alignment.center,
          children: [_buildInteractiveSebha(), _buildCounterDisplay(height)],
        ),
      ],
    );
  }

  // Build the header title widget
  Widget _buildHeaderTitle() {
    return Text("سَبِّحِ اسْمَ رَبِّكَ الأعلى ", style: AppStyles.bold36white);
  }

  // Build the interactive sebha widget with rotation animation
  Widget _buildInteractiveSebha() {
    return GestureDetector(
      onTap: onSebhaTap,
      child: AnimatedRotation(
        turns: turns,
        duration: const Duration(milliseconds: 300),
        child: Image.asset(AppAssets.sebha),
      ),
    );
  }

  // Build the counter display widget to show the current tasbeeh text and counter
  Widget _buildCounterDisplay(double height) {
    return Column(
      children: [
        SizedBox(height: height * 0.12),
        Text(tasbeehList[textIndex], style: AppStyles.bold36white),
        Text("$counter", style: AppStyles.bold36white),
      ],
    );
  }
}
