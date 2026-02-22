import 'package:flutter/material.dart';
import 'package:islami_app/util/app_assets.dart';
import 'package:islami_app/util/app_color.dart';
import 'package:islami_app/util/app_styles.dart';

typedef OnPlay = void Function();
typedef OnMute = void Function();

class RadioItem extends StatelessWidget {
  final bool isPlaying;
  final bool isMuted;
  final OnPlay onPlay;
  final OnMute onMute;
  final String name;

  const RadioItem({
    super.key,
    required this.isPlaying,
    required this.isMuted,
    required this.onPlay,
    required this.onMute,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      // Increased height a bit to avoid overflow
      height: height * 0.16,
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.01,
      ),
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
          image: isPlaying
              ? AssetImage(AppAssets.soundWave)
              : AssetImage(AppAssets.hadethMosque),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        // Added padding inside the container for breathing space
        padding: EdgeInsets.symmetric(vertical: height * 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, // Prevents unnecessary stretching
          children: [
            Flexible(
              child: Text(
                name,
                style: AppStyles.bold20Black,
                overflow: TextOverflow.ellipsis, // Prevent text overflow
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: height * 0.005),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: width * 0.1),
                IconButton(
                  onPressed: onPlay,
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                    size: 50,
                    color: AppColor.blackColor,
                  ),
                ),
                IconButton(
                  onPressed: onMute,
                  icon: Icon(
                    isMuted ? Icons.volume_off : Icons.volume_up,
                    size: 30,
                    color: AppColor.blackColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
