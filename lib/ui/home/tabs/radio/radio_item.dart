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

  const RadioItem({
    super.key,
    required this.isPlaying,
    required this.isMuted,
    required this.onPlay,
    required this.onMute,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: height * 0.13,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Radio ", style: AppStyles.bold20Black),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: width * 0.1),
              IconButton(
                onPressed: onPlay,
                icon: isPlaying
                    ? Icon(Icons.pause, size: 50, color: AppColor.blackColor)
                    : Icon(Icons.play_arrow_rounded, size: 50, color: AppColor.blackColor),
              ),
              IconButton(
                onPressed: onMute,
                icon: isMuted
                    ? Icon(Icons.volume_off, size: 30, color: AppColor.blackColor)
                    : Icon(Icons.volume_up, size: 30, color: AppColor.blackColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}