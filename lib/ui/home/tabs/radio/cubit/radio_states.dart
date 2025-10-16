import 'package:islami_app/model/radio_response.dart';

abstract class RadioStates {}
class RadioInitialState extends RadioStates {}
class RadioLoadingState extends RadioStates {}
class RadioErrorState extends RadioStates {
  String error;
  RadioErrorState(this.error);
}
class RadioSuccessState extends RadioStates {
  List<Radios>? radios;
  RadioSuccessState(this.radios);
}