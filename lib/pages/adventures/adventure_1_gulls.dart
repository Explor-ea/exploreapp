import 'dart:async';
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
    "assets/adventure_1_gulls/SCREEN03_04_05.mp4",
    "assets/adventure_1_gulls/SCREEN06.mp4",
    "assets/adventure_1_gulls/SCREEN07.mp4",
    "assets/adventure_1_gulls/SCREEN08_09.mp4",
  ];

  /// A bunch of adventure params to move through the adventure.
  ///
  /// Note: Although a final object cannot be modified, its fields can be changed. In comparison, a const object and its fields cannot be changed: they’re immutable.
  final Map<String, dynamic> adventureParams = {
    "screen2_continue": false,
    "nothing": 5,

    ///  Set to true if the user is near [48.0485911,-1.7421397]
    "near_eiffel": false,
    "found_eiffel": false,
  };

  /// Enventory containing key-Strings.
  List<String> inventory = [];

  /// Zero based index, references `AdventureData.ADVENTURE_SCREENS`
  int currentScreen = 0;
}

class Adventure1Gulls extends StatefulWidget {
  const Adventure1Gulls({Key? key}) : super(key: key);

  @override
  _Adventure1GullsState createState() => _Adventure1GullsState();
}

class _Adventure1GullsState extends State<Adventure1Gulls> {
  VideoPlayerController? _vpController;
  Future<void>? _initializeVideoPlayerFuture;

  AdventureData _theAdventureData = new AdventureData();

  @override
  void initState() {
    super.initState();

    this.changeCurrentScreenAndLoadAsset(0);

    this.runScreen_1();

    // // REMOVE
    // this._vpController.setLooping(true);
    // this._vpController.setPlaybackSpeed(0.1);
  }

  /// After it, [_vpController] is `!= null`.
  void changeCurrentScreenAndLoadAsset(int newCurrentScreen) {
    // XXX CAREFUL: when putted after the asset asignation, makes errors. And it's asynchronous so...
    if (this._vpController != null && this._vpController!.value.isInitialized)
      this._vpController!.dispose();

    this._theAdventureData.currentScreen = newCurrentScreen;
    this._vpController = VideoPlayerController.asset(
        AdventureData.ADVENTURE_SCREENS[this._theAdventureData.currentScreen]);
  }

  void runScreen_1() {
    this.changeCurrentScreenAndLoadAsset(0);

    this._initializeVideoPlayerFuture =
        this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      this._vpController!.addListener(() {
        // log(this._vpController!.value.position.toString());

        // At first video end.
        if (this._vpController!.value.position ==
            this._vpController!.value.duration) {
          if (this._theAdventureData.currentScreen == 0) {
            this.runScreen_2();
          }
        }
      });
    });
  }

  void runScreen_2() {
    this.changeCurrentScreenAndLoadAsset(1);

    this._vpController!.initialize().then((nothing) {
      // When initialized, the position is aleady at a new Duration value.
      // this._vpController!.seekTo(new Duration()).then((value) {});

      this._vpController!.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      this._vpController!.addListener(() {
        // Show next btn.
        if (this._theAdventureData.adventureParams["screen2_continue"] ==
                false &&
            this._vpController!.value.position > Duration(seconds: 5)) {
          setState(() {
            this._theAdventureData.adventureParams["screen2_continue"] = true;
          });
        }
      });
    });
  }

  void runScreen_3_4_5() {
    this.changeCurrentScreenAndLoadAsset(2);

    this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      this._vpController!.addListener(() {
        if (this._vpController!.value.position ==
            this._vpController!.value.duration) {
          runScreen_6();
        }
      });
    });
  }

  void runScreen_6() {
    this.changeCurrentScreenAndLoadAsset(3);

    this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      this._vpController!.addListener(() {
        if (this._vpController!.value.position ==
            this._vpController!.value.duration) {
          this.runScreen_7();
        }
      });
    });
  }

  /// "L'homme à la dame de fer vous ouvrira le chemin."
  void runScreen_7() {
    this.changeCurrentScreenAndLoadAsset(4);

    this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      this._vpController!.addListener(() {
        if (this._vpController!.value.position ==
            this._vpController!.value.duration) {
          Timer(const Duration(seconds: 5), () {
            this.runScreen_8_9();
          });
        }
      });
    });
  }

  void runScreen_8_9() {
    this.changeCurrentScreenAndLoadAsset(5);

    this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      this._vpController!.addListener(() {
        if (this._theAdventureData.adventureParams["found_eiffel"] == false &&
            this._vpController!.value.position >= const Duration(seconds: 15) &&
            this._theAdventureData.adventureParams["near_eiffel"] == false) {
          this._vpController!.pause();
          this.setState(() {
            // TODO: this should be set when the user is geologically near the point.
            this._theAdventureData.adventureParams["near_eiffel"] = true;
          });
        }
      });

      this._vpController!.addListener(() {
        if (this._vpController!.value.position ==
            this._vpController!.value.duration) {
          // 20 Second after the eiffel point is found, the next screen appears.
          Timer(const Duration(seconds: 20 - (26 - 15)), () {});
        }
      });
    });
  }

  Widget buildCurrentAdventureScreen() {
    Widget ret = Container(
      color: ExploreaColors.purpleDark,
    );

    switch (this._theAdventureData.currentScreen) {
      case 1: // 02
        ret = Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: AspectRatio(
                aspectRatio: 9.0 / 16.0,
                child: VideoPlayer(this._vpController!),
              ),
            ),
            if (this._theAdventureData.adventureParams["screen2_continue"])
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: ExploreaBtnNext(
                    onPressed: () {
                      this.runScreen_3_4_5();
                    },
                  ),
                ),
              )
          ],
        );
        break;

      case 5:
        ret = Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: AspectRatio(
                aspectRatio: 9.0 / 16.0,
                child: VideoPlayer(this._vpController!),
              ),
            ),
            if (this._theAdventureData.adventureParams["near_eiffel"] &&
                this._theAdventureData.adventureParams["found_eiffel"] != true)
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: ExploreaBtnNext(
                    onPressed: () {
                      setState(() {
                        this._theAdventureData.adventureParams["found_eiffel"] =
                            true;

                        this._vpController!.play();
                      });
                    },
                    text: "Oui !",
                  ),
                ),
              )
          ],
        );
        break;

      case 0: // 01
      case 2: // 03 & 04 & 05
      case 3: // 06
      case 4: // 07
      default:
        ret = AspectRatio(
          aspectRatio: 9.0 / 16.0,
          child: VideoPlayer(this._vpController!),
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
