import 'package:flutter/material.dart';
import '../../../../../util/app_color.dart';

class AzkarCounterButton extends StatelessWidget {
  final Size size;
  final int remaining;
  final bool done;
  final VoidCallback onTap;
  final Animation<double> pulseAnimation;

  const AzkarCounterButton({
    super.key,
    required this.size,
    required this.remaining,
    required this.done,
    required this.onTap,
    required this.pulseAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GestureDetector(
        onTap: done ? null : onTap,
        child: AnimatedBuilder(
          animation: pulseAnimation,
          builder: (context, child) =>
              Transform.scale(scale: pulseAnimation.value, child: child),
          child: Container(
            width: size.width * 0.38,
            height: size.width * 0.38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: done
                    ? [Colors.green.shade400, Colors.green.shade800]
                    : [AppColor.primaryColor, AppColor.brown],
                center: Alignment.topLeft,
                radius: 1.4,
              ),
              boxShadow: [
                BoxShadow(
                  color: done ? Colors.green : AppColor.primaryColor,
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: done
                  ? const Icon(Icons.check, color: Colors.white, size: 48)
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$remaining',
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: AppColor.blackColor,
                          ),
                        ),
                        const Text(
                          'remaining',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColor.blackColor,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
