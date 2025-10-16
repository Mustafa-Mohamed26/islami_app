import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/data/api_manager.dart';
import 'package:islami_app/ui/home/tabs/radio/cubit/radio_states.dart';

 class RadioViewModel extends Cubit<RadioStates> {
  RadioViewModel() : super(RadioInitialState());

  

  void getRadio() async {
    emit(RadioLoadingState());
    try {
      var response = await ApiManager.getRadio();
      emit(RadioSuccessState(response?.radios));
    } catch (e) {
      emit(RadioErrorState("Something went wrong"));
    }
  }
}
