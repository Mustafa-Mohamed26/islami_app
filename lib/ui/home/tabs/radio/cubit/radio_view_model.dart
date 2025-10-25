import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/data/api_manager.dart';
import 'package:islami_app/model/reciters_response.dart';
import 'package:islami_app/ui/home/tabs/radio/cubit/radio_states.dart';

class RadioViewModel extends Cubit<RadioStates> {
  RadioViewModel() : super(RadioInitialState());

  /// Get list of radio stations
  Future<void> getRadio() async {
    emit(RadioLoadingState());
    try {
      final response = await ApiManager.getRadio();
      emit(RadioSuccessState(response?.radios));
    } catch (e) {
      emit(RadioErrorState("Something went wrong"));
    }
  }

  /// List of all reciters (cached)
  List<Reciters>? allReciters;

  /// Fetch list of reciters
  Future<void> getReciters() async {
    emit(RecitersLoadingState());
    try {
      final RecitersResponse? response = await ApiManager.getReciters();
      allReciters = response?.reciters ?? [];
      emit(RecitersSuccessState(allReciters!));
    } catch (e) {
      emit(RecitersErrorState("Failed to load reciters"));
    }
  }

  /// ✅ Get full list of surahs (with URLs) for a specific reciter
  List<Map<String, String>> getSurahsForReciter(String reciterName) {
    final reciter = allReciters?.firstWhere(
      (r) => r.name == reciterName,
      orElse: () => Reciters(name: reciterName, moshaf: []),
    );

    if (reciter == null || reciter.moshaf == null || reciter.moshaf!.isEmpty) {
      return [];
    }

    final moshaf = reciter.moshaf!.first; // Most reciters have one moshaf
    final server = moshaf.server ?? '';
    final surahList = moshaf.surahList?.split(',') ?? [];

    // Build list of surahs with their URLs
    final surahs = surahList.map((s) {
      final paddedNumber = s.padLeft(3, '0'); // مثل 001, 002, 114
      final url = '$server$paddedNumber.mp3';
      return {
        'number': s,
        'url': url,
      };
    }).toList();

    return surahs;
  }
}
