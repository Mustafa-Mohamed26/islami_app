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
  int counter = 1;
  int textIndex = 0;
  double turns = 0.0;
  static const int maxCount = 33;
  static const List<String> tasbeehList = [
    "سبحان الله",
    "الحمد لله",
    "لا إله إلا الله",
    "الله أكبر",
    "لا حول ولا قوة إلا بالله",
  ];

  late final AnimationController controller;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 1).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Text("سَبِّحِ اسْمَ رَبِّكَ الأعلى ", style: AppStyles.bold36white),
        Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onTap: onSebhaTap,
              child: AnimatedRotation(
                turns: turns,
                duration: const Duration(milliseconds: 300),
                child: Image.asset(AppAssets.sebha),
              ),
            ),
            Column(
              children: [
                SizedBox(height: height * 0.12),
                Text(tasbeehList[textIndex], style: AppStyles.bold36white),
                Text("$counter", style: AppStyles.bold36white),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
