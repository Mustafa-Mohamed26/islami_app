import 'package:flutter/material.dart';
import '../azkar_data.dart';
import 'azkar_counter_button.dart';
import 'azkar_nav_button.dart';

class AzkarBottomRow extends StatelessWidget {
  final Size size;
  final ValueNotifier<int> currentIndexNotifier;
  final ValueNotifier<int> currentCountNotifier;
  final List<AzkarEntry> azkar;
  final VoidCallback onTap;
  final VoidCallback goBack;
  final VoidCallback goForward;
  final Animation<double> pulseAnimation;

  const AzkarBottomRow({
    super.key,
    required this.size,
    required this.currentIndexNotifier,
    required this.currentCountNotifier,
    required this.azkar,
    required this.onTap,
    required this.goBack,
    required this.goForward,
    required this.pulseAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([currentIndexNotifier, currentCountNotifier]),
      builder: (context, _) {
        final index = currentIndexNotifier.value;
        final count = currentCountNotifier.value;
        final currentEntry = azkar[index];
        final remaining = currentEntry.repeatCount - count;
        final done = count >= currentEntry.repeatCount;
        final isLast = index == azkar.length - 1;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AzkarNavButton(
              icon: Icons.arrow_back_ios,
              onTap: index > 0 ? goBack : null,
            ),
            AzkarCounterButton(
              size: size,
              remaining: remaining,
              done: done,
              onTap: onTap,
              pulseAnimation: pulseAnimation,
            ),
            AzkarNavButton(
              icon: Icons.arrow_forward_ios,
              onTap: !isLast ? goForward : null,
            ),
          ],
        );
      },
    );
  }
}
