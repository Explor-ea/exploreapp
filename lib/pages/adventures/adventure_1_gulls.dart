import 'dart:ui';

import 'package:exploreapp/explorea_colors.dart';
import 'package:exploreapp/wigets/explorea_timer.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

class AdventureData {
  static const List<String> ADVENTURE_SCREENS = [
    "assets/adventure_1_gulls/SCREEN01.mp4",
  ];

  /// Enventory containing key-Strings.
  List<String> inventory = [];

  /// Zero based index, references AdventureData.ADVENTURE_SCREENS
  int currentScreen = 0;
}

class Adventure1Gulls extends StatefulWidget {
  const Adventure1Gulls({Key? key}) : super(key: key);

  @override
  _Adventure1GullsState createState() => _Adventure1GullsState();
}

class _Adventure1GullsState extends State<Adventure1Gulls> {
  late VideoPlayerController _vpController;
  late Future<void> _initializeVideoPlayerFuture;

  AdventureData _theAdventureData = new AdventureData();

  @override
  void initState() {
    super.initState();

    this._theAdventureData.currentScreen = 0;

    this._vpController = VideoPlayerController.asset(
        AdventureData.ADVENTURE_SCREENS[_theAdventureData.currentScreen]);

    this._vpController.setLooping(false);

    this._vpController.initialize();

    this._vpController.play();

    // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            AspectRatio(
              aspectRatio: 9.0 / 16.0,
              child: VideoPlayer(this._vpController),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRect(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(32.0, 16.0, 16.0, 8.0),
                      child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 10,
                            sigmaY: 10,
                          ),
                          child: Row(
                            children: [
                              ExploreaTimer(
                                totalTime: Duration(seconds: 60 * 15),
                              ),
                            ],
                          )),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
