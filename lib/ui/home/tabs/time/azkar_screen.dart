import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_app/ui/home/tabs/time/azkar_data.dart';
import 'package:islami_app/ui/home/tabs/time/widgets/azkar_bottom_row.dart';
import 'package:islami_app/ui/home/tabs/time/widgets/azkar_card.dart';
import 'package:islami_app/ui/home/tabs/time/widgets/azkar_progress_bar.dart';
import 'package:islami_app/util/app_color.dart';
import 'package:islami_app/util/app_styles.dart';

/// Screen that displays either Morning or Evening Azkar.
/// Shows one Azkar at a time with a repeat counter and
/// navigates forward automatically when the count is reached.
class AzkarScreen extends StatefulWidget {
  /// 'morning' or 'evening'
  final String type;

  const AzkarScreen({super.key, required this.type});

  @override
  State<AzkarScreen> createState() => _AzkarScreenState();
}

class _AzkarScreenState extends State<AzkarScreen>
    with SingleTickerProviderStateMixin {
  // ── State ────────────────────────────────────────────────────────────────────

  late final List<AzkarEntry> _azkar;
  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> _currentCountNotifier = ValueNotifier<int>(0);

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  // ── Lifecycle ────────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _azkar = widget.type == 'morning' ? morningAzkar : eveningAzkar;

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _currentIndexNotifier.dispose();
    _currentCountNotifier.dispose();
    super.dispose();
  }

  // ── Getters ──────────────────────────────────────────────────────────────────

  AzkarEntry get _current => _azkar[_currentIndexNotifier.value];
  bool get _isLast => _currentIndexNotifier.value == _azkar.length - 1;
  bool get _isDone => _currentCountNotifier.value >= _current.repeatCount;

  // ── Actions ──────────────────────────────────────────────────────────────────

  void _onTap() {
    if (_isDone) return;
    HapticFeedback.lightImpact();
    _pulseController.forward().then((_) => _pulseController.reverse());

    _currentCountNotifier.value++;

    if (_currentCountNotifier.value >= _current.repeatCount && !_isLast) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          _currentIndexNotifier.value++;
          _currentCountNotifier.value = 0;
        }
      });
    }
  }

  void _goBack() {
    if (_currentIndexNotifier.value > 0) {
      _currentIndexNotifier.value--;
      _currentCountNotifier.value = 0;
    }
  }

  void _goForward() {
    if (!_isLast) {
      _currentIndexNotifier.value++;
      _currentCountNotifier.value = 0;
    }
  }

  // ── Build ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final title = widget.type == 'morning' ? 'Morning Azkar' : 'Evening Azkar';
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColor.blackColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColor.primaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(title, style: AppStyles.bold20Primary),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ValueListenableBuilder<int>(
              valueListenable: _currentIndexNotifier,
              builder: (context, index, _) {
                return Text(
                  '${index + 1} / ${_azkar.length}',
                  style: AppStyles.bold16White,
                );
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            AzkarProgressBar(
              currentIndexNotifier: _currentIndexNotifier,
              currentCountNotifier: _currentCountNotifier,
              azkar: _azkar,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.03),
                    Expanded(
                      child: ValueListenableBuilder<int>(
                        valueListenable: _currentIndexNotifier,
                        builder: (context, index, _) {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            transitionBuilder: (child, animation) =>
                                FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                            child: AzkarCard(
                              key: ValueKey(index),
                              entry: _azkar[index],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    AzkarBottomRow(
                      size: size,
                      currentIndexNotifier: _currentIndexNotifier,
                      currentCountNotifier: _currentCountNotifier,
                      azkar: _azkar,
                      onTap: _onTap,
                      goBack: _goBack,
                      goForward: _goForward,
                      pulseAnimation: _pulseAnimation,
                    ),
                    SizedBox(height: size.height * 0.02),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
