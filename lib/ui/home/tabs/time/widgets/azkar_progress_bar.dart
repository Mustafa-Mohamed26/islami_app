import 'package:flutter/material.dart';
import '../../../../../util/app_color.dart';
import '../azkar_data.dart';

class AzkarProgressBar extends StatelessWidget {
  final ValueNotifier<int> currentIndexNotifier;
  final ValueNotifier<int> currentCountNotifier;
  final List<AzkarEntry> azkar;

  const AzkarProgressBar({
    super.key,
    required this.currentIndexNotifier,
    required this.currentCountNotifier,
    required this.azkar,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([currentIndexNotifier, currentCountNotifier]),
      builder: (context, _) {
        final index = currentIndexNotifier.value;
        final count = currentCountNotifier.value;
        final repeatCount = azkar[index].repeatCount;
        return LinearProgressIndicator(
          value: (index + (count / repeatCount)) / azkar.length,
          backgroundColor: AppColor.blackBgColor,
          valueColor: const AlwaysStoppedAnimation<Color>(
            AppColor.primaryColor,
          ),
          minHeight: 4,
        );
      },
    );
  }
}
