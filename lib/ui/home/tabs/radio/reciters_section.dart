import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/providers/radio_manager_provider.dart';
import 'package:islami_app/ui/home/tabs/quran/quran_resources.dart';
import 'package:islami_app/ui/home/tabs/radio/radio_item.dart';
import 'package:islami_app/ui/home/tabs/radio/reciter_drop_down.dart';
import 'package:islami_app/util/app_styles.dart';
import 'package:provider/provider.dart';
import 'package:islami_app/model/reciters_response.dart';
import 'package:islami_app/ui/home/tabs/radio/cubit/radio_view_model.dart';
import 'package:islami_app/ui/home/tabs/radio/cubit/radio_states.dart';

class RecitersSection extends StatefulWidget {
  const RecitersSection({super.key});

  @override
  State<RecitersSection> createState() => _RecitersSectionState();
}

class _RecitersSectionState extends State<RecitersSection> {
  int? playingIndex;
  Reciters? selectedReciter;
  List<Map<String, String>>? currentSurahs;

  @override
  void deactivate() {
    final radioManager = Provider.of<RadioMangerProvider>(
      context,
      listen: false,
    );
    radioManager.stop(radioManager.currentPlayingUrl ?? '');
    playingIndex = null;
    super.deactivate();
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RadioViewModel>(context).getReciters();
  }

  @override
  Widget build(BuildContext context) {
    final radioManager = Provider.of<RadioMangerProvider>(context);
    final viewModel = BlocProvider.of<RadioViewModel>(context);

    return BlocBuilder<RadioViewModel, RadioStates>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is RadioLoadingState || state is RecitersLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is RecitersErrorState) {
          return Center(child: Text(state.error, style: AppStyles.bold20Primary));
        }

        if (state is RecitersSuccessState) {
          final reciters = state.reciters;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ReciterDropdown(
                reciters: reciters,
                selectedReciter: selectedReciter,
                onChanged: (value) {
                  setState(() {
                    selectedReciter = value;
                    currentSurahs = viewModel.getSurahsForReciter(value!.name!);
                    playingIndex = null;
                  });
                },
              ),

              const SizedBox(height: 8),

              if (selectedReciter == null)
                Center(
                  child: Text("Please select a reciter", style: AppStyles.bold20Primary),
                )
              else if (currentSurahs == null || currentSurahs!.isEmpty)
                Center(
                  child: Text("No surahs found for ${selectedReciter!.name}", style: AppStyles.bold20Primary),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: currentSurahs!.length,
                    itemBuilder: (context, index) {
                      final surah = currentSurahs![index];
                      final url = surah['url'] ?? '';
                      final number = int.tryParse(surah['number'] ?? '0') ?? 0;

                      // Get surah name from QuranResources
                      final surahName = (number >= 1 && number <= QuranResources.arabicQuranList.length)
                          ? QuranResources.arabicQuranList[number - 1]
                          : "Not Found";

                      return RadioItem(
                        key: ValueKey(index),
                        name: "سورة $surahName",
                        isPlaying: playingIndex == index,
                        isMuted: false,
                        onPlay: () {
                          if (playingIndex == index) {
                            radioManager.stop(url);
                            setState(() => playingIndex = null);
                          } else {
                            radioManager.play(url);
                            setState(() => playingIndex = index);
                          }
                        },
                        onMute: () {},
                      );
                    },
                  ),
                ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
