import 'dart:developer';
import 'dart:ui';

import 'package:exploreapp/explorea_colors.dart';
import 'package:exploreapp/wigets/explorea_btn_next.dart';
import 'package:exploreapp/wigets/explorea_timer.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

class AdventureData {
  static const List<String> ADVENTURE_SCREENS = [
    "assets/adventure_1_gulls/SCREEN01.mp4",
    "assets/adventure_1_gulls/SCREEN02.mp4",
  ];

  /// A bunch of adventure params to move through the adventure.
  ///
  /// Note: Although a final object cannot be modified, its fields can be changed. In comparison, a const object and its fields cannot be changed: they’re immutable.
  final Map<String, dynamic> adventureParams = {
    "screen2_continue": false,
    "nothing": 5
  };

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

    this.runScreen_1();

    // // REMOVE
    // this._vpController.setLooping(true);
    // this._vpController.setPlaybackSpeed(0.1);
  }

  void runScreen_1() {
    // XXX : REMETTRE A 0
    this._theAdventureData.currentScreen = 0;

    this._vpController = VideoPlayerController.asset(
        AdventureData.ADVENTURE_SCREENS[this._theAdventureData.currentScreen]);

    this._initializeVideoPlayerFuture =
        this._vpController.initialize().then((nothing) {
      this._vpController.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      this._vpController.addListener(() {
        // log(this._vpController.value.position.toString());

        // At first video end.
        if (this._vpController.value.position ==
            this._vpController.value.duration) {
          if (this._theAdventureData.currentScreen == 0) {
            this.runScreen_2();
          }
        }
      });
    });
  }

  void runScreen_2() {
    this._vpController.dispose();

    this._theAdventureData.currentScreen = 1;
    this._vpController = VideoPlayerController.asset(
        AdventureData.ADVENTURE_SCREENS[this._theAdventureData.currentScreen]);

    this._vpController.initialize().then((nothing) {
      // When initialized, the position is aleady at a new Duration value.
      // this._vpController.seekTo(new Duration()).then((value) {});

      this._vpController.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      this._vpController.addListener(() {
        // Show next btn.
        if (this._theAdventureData.adventureParams["screen2_continue"] ==
                false &&
            this._vpController.value.position > Duration(seconds: 5)) {
          setState(() {
            this._theAdventureData.adventureParams["screen2_continue"] = true;
          });
        }
      });
    });
  }

  Widget buildCurrentAdventureScreen() {
    Widget ret = Container(
      color: ExploreaColors.purpleDark,
    );

    switch (this._theAdventureData.currentScreen) {
      case 0:
        ret = AspectRatio(
          aspectRatio: 9.0 / 16.0,
          child: VideoPlayer(this._vpController),
        );
        break;

      case 1:
        ret = Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: AspectRatio(
                aspectRatio: 9.0 / 16.0,
                child: VideoPlayer(this._vpController),
              ),
            ),
            if (this._theAdventureData.adventureParams["screen2_continue"])
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: ExploreaBtnNext(
                    onPressed: () {},
                  ),
                ),
              )
          ],
        );
        break;

      case 2:
        break;

      default:
        ret = AspectRatio(
          aspectRatio: 9.0 / 16.0,
          child: VideoPlayer(this._vpController),
        );
        break;
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ExploreaColors.purple,
        body: Stack(
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: this.buildCurrentAdventureScreen()),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ExploreaTimer(
                                totalTime: Duration(seconds: 60 * 15),
                                borderColor: Colors.white,
                              ),

                              //

                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    color: Colors.black.withOpacity(0.0)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4.0),
                                  child: Icon(Icons.backpack_outlined,
                                      color: Colors.white),
                                ),
                              ),

                              //

                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    color: Colors.black.withOpacity(0.0)),
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 4.0),
                                    child: Text(
                                      "Indices",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18.0),
                                    )),
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
