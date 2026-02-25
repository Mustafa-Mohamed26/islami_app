import 'package:islami_app/model/prayer_response_model.dart';

abstract class TimeStates {}

class TimeInitial extends TimeStates {}
class TimeLoadingState extends TimeStates {}
class TimeErrorState extends TimeStates {
  final String error;
  TimeErrorState(this.error);
}
class TimeSuccessState extends TimeStates {
  final PrayerResponseModel prayerResponseModel;
  TimeSuccessState(this.prayerResponseModel);
}
