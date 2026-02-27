import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/data/api_manager.dart';
import 'package:islami_app/model/prayer_response_model.dart';
import 'package:islami_app/ui/home/tabs/time/cubit/time_states.dart';

/// Cubit that owns all prayer-time business logic.
///
/// Responsibilities:
///  1. Fetches prayer data from the API via [getPrayerTime].
///  2. Starts a 1-second periodic [Timer] after a successful response so the
///     "next prayer" countdown in the UI stays accurate to the second.
///  3. Cancels the timer automatically when the cubit is closed.
class TimeViewModel extends Cubit<TimeStates> {
  TimeViewModel() : super(const TimeInitialState());

  // Cached response so the timer can re-emit it every second.
  PrayerResponseModel? _prayerData;
  Timer? _countdownTimer;

  // ── Public API ───────────────────────────────────────────────────────────────

  /// Fetches today's prayer data and starts the 1-second countdown timer.
  Future<void> getPrayerTime() async {
    emit(const TimeLoadingState());
    try {
      final response = await ApiManager.getPrayingData();
      if (response != null) {
        _prayerData = response;
        emit(TimeSuccessState(response));
        _startCountdownTimer();
      } else {
        emit(const TimeErrorState('No data received from the server.'));
      }
    } catch (e) {
      emit(TimeErrorState('Failed to load prayer times: $e'));
    }
  }

  // ── Private helpers ──────────────────────────────────────────────────────────

  /// Fires every second, re-emitting [TimeSuccessState] with a fresh
  /// [TimeSuccessState.lastUpdated] timestamp so [BlocBuilder] rebuilds the
  /// countdown widget.
  void _startCountdownTimer() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_prayerData != null && !isClosed) {
        emit(TimeSuccessState(_prayerData!));
      }
    });
  }

  // ── Lifecycle ────────────────────────────────────────────────────────────────

  @override
  Future<void> close() {
    _countdownTimer?.cancel();
    return super.close();
  }
}
