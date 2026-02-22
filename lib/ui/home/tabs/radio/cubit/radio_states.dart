// radio_states.dart
import 'package:islami_app/model/radio_response.dart';
import 'package:islami_app/model/reciters_response.dart';

abstract class RadioStates {}

// ✅ Radio states
class RadioInitialState extends RadioStates {}
class RadioLoadingState extends RadioStates {}
class RadioErrorState extends RadioStates {
  final String error;
  RadioErrorState(this.error);
}
class RadioSuccessState extends RadioStates {
  final List<Radios>? radios;
  RadioSuccessState(this.radios);
}

// ✅ Reciters states
class RecitersLoadingState extends RadioStates {}
class RecitersErrorState extends RadioStates {
  final String error;
  RecitersErrorState(this.error);
}
class RecitersSuccessState extends RadioStates {
  final List<Reciters> reciters;
  RecitersSuccessState(this.reciters);
}
