import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/data/api_manager.dart';
import 'package:islami_app/ui/home/tabs/time/cubit/time_states.dart';

class TimeViewModel extends Cubit<TimeStates> {
  TimeViewModel() : super(TimeInitial());

  Future<void> getPrayerTime() async {
    emit(TimeLoadingState());
    try {
      final response = await ApiManager.getPrayingData();
      if (response != null) {
        emit(TimeSuccessState(response));
      } else {
        emit(TimeErrorState("No data received"));
      }
    } catch (e) {
      emit(TimeErrorState("Something went wrong"));
    }
  }
}
