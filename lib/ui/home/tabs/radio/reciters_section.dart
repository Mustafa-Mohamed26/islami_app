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
  int? playingIndex; // Variable to track the currently playing radio station index
  int? mutedIndex; // Variable to track the currently muted radio station index
  Reciters? selectedReciter; // Variable to store the selected reciter
  List<Map<String, String>>? currentSurahs; // List to store the surahs of the selected reciter

  // Called when the widget is removed from the widget tree
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

  // Called when the widget is inserted into the widget tree
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RadioViewModel>(context).getReciters();
  }

  // Build the RecitersSection widget
  @override
  Widget build(BuildContext context) {
    final radioManager = Provider.of<RadioMangerProvider>(context);
    final viewModel = BlocProvider.of<RadioViewModel>(context);

    return BlocBuilder<RadioViewModel, RadioStates>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is RadioLoadingState || state is RecitersLoadingState) {
          return _buildLoading();
        }

        if (state is RecitersErrorState) {
          return _buildError(state.error);
        }

        if (state is RecitersSuccessState) {
          return _buildRecitersContent(state.reciters, viewModel, radioManager);
        }

        return const SizedBox.shrink();
      },
    );
  }

  // Build the loading indicator widget
  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  // Build the error message widget
  Widget _buildError(String errorMsg) {
    return Center(child: Text(errorMsg, style: AppStyles.bold20Primary));
  }

  // Build the reciters content widget
  Widget _buildRecitersContent(
    List<Reciters>? reciters,
    RadioViewModel viewModel,
    RadioMangerProvider radioManager,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ReciterDropdown(
          reciters: reciters ?? [],
          selectedReciter: selectedReciter,
          onChanged: (value) => _onReciterSelected(value, viewModel),
        ),
        const SizedBox(height: 8),
        _buildSurahSelectionState(radioManager),
      ],
    );
  }

  // Handle reciter selection and update the state accordingly
  void _onReciterSelected(Reciters? value, RadioViewModel viewModel) {
    setState(() {
      selectedReciter = value;
      currentSurahs = viewModel.getSurahsForReciter(value!.name!);
      playingIndex = null;
      mutedIndex = null;
    });
  }

  // Handle play/pause actions for the radio stations
  Widget _buildSurahSelectionState(RadioMangerProvider radioManager) {
    if (selectedReciter == null) {
      return Center(
        child: Text("Please select a reciter", style: AppStyles.bold20Primary),
      );
    }

    if (currentSurahs == null || currentSurahs!.isEmpty) {
      return Center(
        child: Text(
          "No surahs found for ${selectedReciter!.name}",
          style: AppStyles.bold20Primary,
        ),
      );
    }

    return _buildSurahsList(radioManager);
  }

  // Build the list of radio stations
  Widget _buildSurahsList(RadioMangerProvider radioManager) {
    return Expanded(
      child: ListView.builder(
        itemCount: currentSurahs!.length,
        itemBuilder: (context, index) {
          final surah = currentSurahs![index];
          final url = surah['url'] ?? '';
          final number = int.tryParse(surah['number'] ?? '0') ?? 0;

          // Get surah name from QuranResources
          final surahName =
              (number >= 1 && number <= QuranResources.arabicQuranList.length)
              ? QuranResources.arabicQuranList[number - 1]
              : "Not Found";

          return RadioItem(
            key: ValueKey(index),
            name: "سورة $surahName",
            isPlaying: playingIndex == index,
            isMuted: mutedIndex == index,
            onPlay: () => _handlePlayPause(index, url, radioManager),
            onMute: () => _handleMuteUnmute(index, url, radioManager),
          );
        },
      ),
    );
  }

  // Handle play/pause actions for the radio stations
  void _handlePlayPause(
    int index,
    String url,
    RadioMangerProvider radioManager,
  ) {
    if (playingIndex == index) {
      radioManager.stop(url);
      setState(() => playingIndex = null);
    } else {
      radioManager.play(url);
      setState(() => playingIndex = index);
    }
  }

  // Handle mute/unmute actions for the radio stations
  void _handleMuteUnmute(
    int index,
    String url,
    RadioMangerProvider radioManager,
  ) {
    setState(() {
      if (mutedIndex == index) {
        mutedIndex = null;
      } else {
        mutedIndex = index;
      }
    });

    if (mutedIndex == index) {
      radioManager.mute(url, 0);
    } else {
      radioManager.mute(url, 1);
    }
  }
}
