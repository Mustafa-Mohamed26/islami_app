import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/providers/radio_manager_provider.dart';
import 'package:islami_app/ui/home/tabs/radio/cubit/radio_states.dart';
import 'package:islami_app/ui/home/tabs/radio/cubit/radio_view_model.dart';
import 'package:islami_app/ui/home/tabs/radio/radio_item.dart';
import 'package:islami_app/util/app_styles.dart';
import 'package:provider/provider.dart';

class RadioSection extends StatefulWidget {
  const RadioSection({super.key});

  @override
  State<RadioSection> createState() => _RadioSectionState();
}

class _RadioSectionState extends State<RadioSection> {
  int? playingIndex;
  int? mutedIndex;

  @override
  void deactivate() {
    // Called when the widget is removed from the widget tree (e.g. when user leaves the tab)
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
    BlocProvider.of<RadioViewModel>(context).getRadio();
  }

  @override
  Widget build(BuildContext context) {
    final radioManager = Provider.of<RadioMangerProvider>(context);
    final viewModel = BlocProvider.of<RadioViewModel>(context);

    return BlocBuilder<RadioViewModel, RadioStates>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is RadioLoadingState) {
          return _buildLoading();
        }

        if (state is RadioErrorState) {
          return _buildError(state.error);
        }

        if (state is RadioSuccessState) {
          return _buildRadiosList(state.radios ?? [], radioManager);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildError(String errorMsg) {
    return Center(child: Text(errorMsg, style: AppStyles.bold20Primary));
  }

  Widget _buildRadiosList(List radios, RadioMangerProvider radioManager) {
    return Expanded(
      child: ListView.builder(
        itemCount: radios.length,
        itemBuilder: (context, index) {
          final radio = radios[index];

          return RadioItem(
            key: ValueKey(index),
            // Display the radio name (or "Unknown" if it's null)
            name: radio.name ?? "Unknown",

            // Check if this radio station is currently playing
            isPlaying: playingIndex == index,

            // Check if this radio station is currently muted
            isMuted: mutedIndex == index,

            // When the play/pause button is pressed
            onPlay: () => _handlePlayPause(index, radio.url, radioManager),

            // When the mute/unmute button is pressed
            onMute: () => _handleMuteUnmute(index, radio.url, radioManager),
          );
        },
      ),
    );
  }

  void _handlePlayPause(
    int index,
    String? url,
    RadioMangerProvider radioManager,
  ) {
    setState(() {
      // If the same station is playing → stop it
      if (playingIndex == index) {
        playingIndex = null;
      }
      // Otherwise → set this station as the currently playing one
      else {
        playingIndex = index;
      }
    });

    // If the selected station is the current one → play it
    if (playingIndex == index) {
      radioManager.play(url ?? '');
    }
    // Otherwise → stop playback
    else {
      radioManager.stop(url ?? '');
    }
  }

  void _handleMuteUnmute(
    int index,
    String? url,
    RadioMangerProvider radioManager,
  ) {
    setState(() {
      // If this station is already muted → unmute it
      if (mutedIndex == index) {
        mutedIndex = null;
      }
      // Otherwise → mute this station
      else {
        mutedIndex = index;
      }
    });

    // If it's muted → set volume to 0
    if (mutedIndex == index) {
      radioManager.mute(url ?? '', 0);
    }
    // If it's unmute → set volume back to 1
    else {
      radioManager.mute(url ?? '', 1);
    }
  }
}
