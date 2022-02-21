import 'package:exploreapp/explorea_colors.dart';
import 'package:exploreapp/pages/interactive_map.dart';
import 'package:exploreapp/src/navigation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Cinematic extends StatelessWidget {
  const Cinematic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VideoPlayerController _vpController =
        new VideoPlayerController.asset("assets/EXPLOREA_LOGO_16-9.mp4");

    _vpController.initialize().then((nothing) {
      _vpController.play();

      _vpController.addListener(() {
        if (_vpController.value.position == _vpController.value.duration) {
          goToNextPage(context, InteractiveMap());
        }
      });
    });

    return Scaffold(
      // backgroundColor: ExploreaColors.yellow,
      backgroundColor: ExploreaColors.purple,
      body: Align(
          alignment: Alignment.center,
          child: AspectRatio(
            aspectRatio: 9.0 / 16.0,
            child: VideoPlayer(_vpController),
          )),
    );
  }
}
