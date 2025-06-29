import 'package:flutter/material.dart';
import 'package:islami_app/ui/home/tabs/radio/radio_item.dart';

class RadioSection extends StatefulWidget {
  const RadioSection({super.key});

  @override
  State<RadioSection> createState() => _RadioSectionState();
}

class _RadioSectionState extends State<RadioSection> {
  int? playingIndex;
  int? mutedIndex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 10,
        itemBuilder: (context, index) {
          return RadioItem(
            isPlaying: playingIndex == index,
            isMuted: mutedIndex == index,
            onPlay: () {
              setState(() {
                if (playingIndex == index) {
                  playingIndex = null; // Stop playing if already playing
                } else {
                  playingIndex = index; // Play only this one
                }
              });
            },
            onMute: () {
              setState(() {
                if (mutedIndex == index) {
                  mutedIndex = null; // Unmute if already muted
                } else {
                  mutedIndex = index; // Mute only this one
                }
              });
            },
          );
        },
      ),
    );
  }
}
