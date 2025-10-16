import 'package:flutter/material.dart';
import 'package:islami_app/ui/home/tabs/radio/radio_item.dart';

class RecitersSection extends StatefulWidget {
  const RecitersSection({super.key});

  @override
  State<RecitersSection> createState() => _RecitersSectionState();
}

class _RecitersSectionState extends State<RecitersSection> {
  int? playingIndex;
  int? mutedIndex;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
        itemCount: 10,
        itemBuilder: (context, index) {
          return RadioItem(
            isPlaying: playingIndex == index,
            isMuted: mutedIndex == index,
            name: 'Reciter ${index + 1}',
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
      );
    
  }
}