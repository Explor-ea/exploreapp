import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:exploreapp/explorea_colors.dart';
import 'package:exploreapp/src/permissions.dart';
import 'package:exploreapp/wigets/explorea_btn_next.dart';
import 'package:exploreapp/wigets/explorea_inventory.dart';
import 'package:exploreapp/wigets/explorea_throwable_container.dart';
import 'package:exploreapp/wigets/explorea_timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:video_player/video_player.dart';
import 'package:geolocator/geolocator.dart';

class AdventureData extends ChangeNotifier {
  static const List<String> ADVENTURE_SCREENS = [
    "assets/adventure_1_gulls/SCREEN01.mp4", // 00
    "assets/adventure_1_gulls/SCREEN02.mp4",
    "assets/adventure_1_gulls/SCREEN03_04_05.mp4", // 02
    "assets/adventure_1_gulls/SCREEN06.mp4",
    "assets/adventure_1_gulls/SCREEN07.mp4", // 04
    "assets/adventure_1_gulls/SCREEN08_09.mp4",
    "assets/adventure_1_gulls/SCREEN10.mp4", // 06
    "assets/adventure_1_gulls/SCREEN12.mp4",
    "assets/adventure_1_gulls/SCREEN13.mp4", // 08
    "assets/adventure_1_gulls/SCREEN14.mp4",
    "assets/adventure_1_gulls/SCREEN15.mp4", // 10
    "assets/adventure_1_gulls/SCREEN16.mp4",
    "assets/adventure_1_gulls/SCREEN17.mp4", // 12
    "assets/adventure_1_gulls/SCREEN18.mp4",
    "assets/adventure_1_gulls/SCREEN19.png", // 14
  ];

  /// A bunch of adventure params to move through the adventure.
  ///
  /// Note: Although a final object cannot be modified, its fields can be changed. In comparison, a const object and its fields cannot be changed: they’re immutable.
  final Map<String, dynamic> adventureParams = {
    "screen2_continue": false,
    "nothing": 5,

    /// Set to true if the user is near [48.0485911,-1.7421397]
    "near_eiffel": false,
    "found_eiffel": false,

    // TODO: set it onTap with the ExploreaInventory
    /// Selection from the inventory.
    "selected_item": null,
  };

  //
  // Timer

  int currentTime = (60 * 15);

  decrementTimer() {
    currentTime--;
    notifyListeners();
  }

  // Timer
  //

  //
  // Inventory

  /// Enventory containing key-Strings.
  List<String> inventory = [];
  String? selectedItem;

  addItem(String itemId) {
    this.inventory.add(itemId);

    notifyListeners();
  }

  removeItem(String itemId) {
    this.inventory.remove(itemId);

    notifyListeners();
  }

  selectItem(String itemSelected) {
    if (this.selectedItem == itemSelected)
      this.selectedItem = null;
    else
      this.selectedItem = itemSelected;

    notifyListeners();
  }

  static String? getAssetForItem(String itemId) {
    switch (itemId) {
      case "fish_blue":
        return "assets/adventure_1_gulls/items/fish_blue.png";
      case "fish_grey":
        return "assets/adventure_1_gulls/items/fish_grey.png";
      case "fish_red":
        return "assets/adventure_1_gulls/items/fish_red.png";

      default:
        return null;
    }
  }

  // Inventory
  //

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

  bool _nextBtnIsDisplayed = false;

  AdventureData _theAdventureData = new AdventureData();

  final LocationSettings _locationSettings = new LocationSettings(
    accuracy: LocationAccuracy.best,
    distanceFilter: 2,
  );

  bool _inventoryIsOpen = false;

  @override
  void initState() {
    super.initState();

    var advTimer = Timer.periodic(Duration(seconds: 1), (advTimer) {
      if (this._theAdventureData.currentTime > 0)
        this._theAdventureData.decrementTimer();
      else
        advTimer.cancel();
    });

    // If somehow the location permission has not been agreed, display an error Widget.
    checkAndAskPosition().then((permission) {
      if (permission.index < 2) {
        setState(() {
          this._theAdventureData.currentScreen = 9000;
        });
      }
    });

    this.changeCurrentScreenAndLoadAsset(0);

    // this.runScreen_1();
    this.runScreen_18();

    // // REMOVE
    // this._vpController.setLooping(true);
    // this._vpController.setPlaybackSpeed(0.1);
  }

  /// After it, [_vpController] is `!= null`.
  void changeCurrentScreenAndLoadAsset(int newCurrentScreen,
      {bool resetNextBtn: true}) {
    if (resetNextBtn) this._nextBtnIsDisplayed = false;

    // XXX CAREFUL: when putted after the asset asignation, makes errors. And it's asynchronous so...
    if (this._vpController != null && this._vpController!.value.isInitialized)
      this._vpController!.dispose();

    this._theAdventureData.currentScreen = newCurrentScreen;
    this._vpController = VideoPlayerController.asset(
        AdventureData.ADVENTURE_SCREENS[this._theAdventureData.currentScreen]);
  }

  void runNextScreen() {
    switch (++this._theAdventureData.currentScreen) {
      case 0:
        this.runScreen_1();
        break;
      case 1:
        this.runScreen_2();
        break;
      case 2:
        this.runScreen_3_4_5();
        break;
      case 3:
        this.runScreen_6();
        break;
      case 4:
        this.runScreen_7();
        break;
      case 5:
        this.runScreen_8_9();
        break;
      case 6:
        this.runScreen_10();
        break;
      case 7:
        this.runScreen_12();
        break;
      case 8:
        this.runScreen_13();
        break;
      case 9:
        this.runScreen_14();
        break;
      case 10:
        this.runScreen_15();
        break;
      case 11:
        this.runScreen_16();
        break;
      case 12:
        this.runScreen_17();
        break;
      case 13:
        this.runScreen_18();
        break;

      default:
        break;
    }
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
          Timer(const Duration(seconds: 20 - (26 - 15)), () {
            this.runScreen_10();
          });
        }
      });
    });
  }

  /// With the porthole accross the univers.
  void runScreen_10() {
    this.changeCurrentScreenAndLoadAsset(6);

    this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      // TODO: add vibration.

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      StreamSubscription<Position>? positionStream;
      positionStream =
          Geolocator.getPositionStream(locationSettings: _locationSettings)
              .listen((Position? currentPosition) {
        if (currentPosition != null) {
          const pointCoordinates = [48.048873, -1.741273];
          double distanceFromThePoint = Geolocator.distanceBetween(
              pointCoordinates[0],
              pointCoordinates[1],
              currentPosition.latitude,
              currentPosition.longitude);

          if (distanceFromThePoint <= 10 /* metters */) {
            positionStream!.cancel();

            this.runScreen_12();
          }
        }
      });
    });
  }

  /// With the fisherman.
  void runScreen_12() {
    this.changeCurrentScreenAndLoadAsset(7);

    this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      this._vpController!.addListener(() {
        if (this._vpController!.value.position ==
            this._vpController!.value.duration) {
          this.runScreen_13();
        }
      });
    });
  }

  /// The fishes in the basket.
  void runScreen_13() {
    this.changeCurrentScreenAndLoadAsset(8);

    this._vpController!.setLooping(true);

    this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
    });
  }

  /// Return back to the portal !.
  void runScreen_14() {
    this.changeCurrentScreenAndLoadAsset(9);

    this._vpController!.setLooping(false);

    this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      // Loop the video from the middle.
      this._vpController!.addListener(() {
        if (this._vpController!.value.position >= const Duration(seconds: 13)) {
          this
              ._vpController!
              .seekTo(const Duration(seconds: 5))
              .then((nothing) {
            this._vpController!.play();
            setState(() {});
          });
        }
      });

      // Run the next screen when arrived at the point.
      StreamSubscription<Position>? positionStream;
      positionStream =
          Geolocator.getPositionStream(locationSettings: _locationSettings)
              .listen((Position? currentPosition) {
        if (currentPosition != null) {
          const pointCoordinates = [48.04856, -1.74249];
          double distanceFromThePoint = Geolocator.distanceBetween(
              pointCoordinates[0],
              pointCoordinates[1],
              currentPosition.latitude,
              currentPosition.longitude);

          if (distanceFromThePoint <= 7 /* metters */) {
            positionStream!.cancel();

            this.runScreen_15();
          }
        }
      });
    });
  }

  /// Throw the fish.
  void runScreen_15() {
    this.changeCurrentScreenAndLoadAsset(10);

    this._vpController!.setLooping(false);

    this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
    });
  }

  /// The seagulls are eating.
  void runScreen_16() {
    this.changeCurrentScreenAndLoadAsset(11);

    this._vpController!.setLooping(false);

    this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      this._vpController!.addListener(() {
        if (this._vpController!.value.position ==
            this._vpController!.value.duration) {
          this.runScreen_17();
        }
      });
    });
  }

  /// The rat shout : let's go.
  void runScreen_17() {
    this.changeCurrentScreenAndLoadAsset(12);

    this._vpController!.setLooping(true);

    this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      this._vpController!.addListener(() {
        if (!this._nextBtnIsDisplayed &&
            this._vpController!.value.position > const Duration(seconds: 2)) {
          setState(() {
            this._nextBtnIsDisplayed = true;
          });
        }
      });
    });
  }

  /// Enter the portal.
  void runScreen_18() {
    this.changeCurrentScreenAndLoadAsset(13);

    this._vpController!.setLooping(false);

    this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      this._vpController!.addListener(() {
        if (this._vpController!.value.position ==
            this._vpController!.value.duration) {
          this.runScreen_19();
        }
      });
    });
  }

  /// Panorama.
  void runScreen_19() {
    // this.changeCurrentScreenAndLoadAsset(14);

    this._theAdventureData.currentScreen = 14;

    setState(() {});

    if (this._vpController != null && this._vpController!.value.isInitialized)
      this._vpController!.dispose().then((value) {
        setState(() {});
      });

    // this._vpController!.setLooping(false);
  }

  // Listen user's position and run 11 screen

  Widget buildCurrentAdventureScreen() {
    Widget ret = Container(
      color: ExploreaColors.purpleDark,
    );

    switch (this._theAdventureData.currentScreen) {
      case 9000:
        ret = Container(
          child: Text(
              "Explor'ea doit pouvoir accéder à votre position pour cette adventure."),
        );
        break;

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

      case 5: // 08 & 09
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

      case 8: // 13
        ret = Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: AspectRatio(
                aspectRatio: 9.0 / 16.0,
                child: VideoPlayer(this._vpController!),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: 0.5,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: GestureDetector(
                          child:
                              Container(color: Colors.black.withOpacity(0.0)),
                          onTap: () {
                            setState(() {
                              this._theAdventureData.inventory.add("fish_grey");
                              this.runScreen_14();
                            });
                            log("clic poisson gris");
                          }),
                    ),
                    Expanded(
                      child: GestureDetector(
                          child:
                              Container(color: Colors.black.withOpacity(0.0)),
                          onTap: () {
                            setState(() {
                              this._theAdventureData.inventory.add("fish_red");
                              this.runScreen_14();
                            });
                            log("clic poisson rouge");
                          }),
                    ),
                    Expanded(
                      child: GestureDetector(
                          child:
                              Container(color: Colors.black.withOpacity(0.0)),
                          onTap: () {
                            setState(() {
                              this._theAdventureData.inventory.add("fish_blue");
                              this.runScreen_14();
                            });
                            log("clic poisson bleu");
                          }),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
        break;

      case 10: // 15
        ret = ChangeNotifierProvider(
          create: (context) => this._theAdventureData,
          child: Consumer<AdventureData>(
            builder: (context, theAdvData, child) => Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AspectRatio(
                    aspectRatio: 9.0 / 16.0,
                    child: VideoPlayer(this._vpController!),
                  ),
                ),
                // Check if fish, not any != null
                if (theAdvData.selectedItem != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 50.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ExploreaThrowableContainer(
                        onThrowed: () {
                          this
                              ._theAdventureData
                              .removeItem(theAdvData.selectedItem!);

                          this.runScreen_16();
                        },
                        child: Container(
                          // The Fish.

                          width: 200.0,
                          height: 200.0,
                          // color: ExploreaColors.yellow,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(AdventureData.getAssetForItem(
                                        this._theAdventureData.selectedItem!) ??
                                    "assets/icon/question_mark.png"),
                                fit: BoxFit.contain),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        );
        break;

      case 14: // 19
        ret = Stack(
          children: [
            // Scrollable Panorama
            Align(
                alignment: Alignment.bottomCenter,
                child: AspectRatio(
                  aspectRatio: 9.0 / 16.0,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      // XXX CAREFUL: This code might not work on all devices.
                      width: 1400.0,
                      decoration: BoxDecoration(
                          // gradient: LinearGradient(
                          //     colors: [Colors.pink, Colors.cyan]),
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/adventure_1_gulls/Panorama.png"))),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 165.0,
                            top: 185.0,
                            // Blue Container.
                            child: Container(
                              width: 100.0,
                              height: 150.0,
                              // color: Colors.pink.withOpacity(0.5),
                            ),
                          ),
                          Positioned(
                            left: 350.0,
                            top: 210.0,
                            // Yellow Container.
                            child: Container(
                              width: 100.0,
                              height: 110.0,
                              // color: Colors.pink.withOpacity(0.5),
                            ),
                          ),
                          Positioned(
                            left: 450.0,
                            top: 170.0,
                            // Red Container.
                            child: Container(
                              width: 155.0,
                              height: 200.0,
                              // color: Colors.pink.withOpacity(0.5),
                            ),
                          ),
                          Positioned(
                            left: 610.0,
                            top: 170.0,
                            // Green Container.
                            child: Container(
                              width: 205.0,
                              height: 225.0,
                              // color: Colors.pink.withOpacity(0.5),
                            ),
                          ),
                          Positioned(
                            left: 1010.0,
                            top: 210.0,
                            // Generator sign.
                            child: GestureDetector(
                              onTap: () {
                                log("Click on sign.");
                              },
                              child: Container(
                                width: 40.0,
                                height: 120.0,
                                color: Colors.pink.withOpacity(0.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),

            // // Frame
            // Align(
            //     alignment: Alignment.bottomCenter,
            //     child: AspectRatio(
            //       aspectRatio: 9.0 / 16.0,
            //       child: Container(
            //           decoration: BoxDecoration(
            //               image: DecorationImage(
            //                   image: AssetImage(AdventureData.ADVENTURE_SCREENS[
            //                       this._theAdventureData!.currentScreen])))),
            //     )),
          ],
        );
        break;

      case 0: // 01
      case 2: // 03 & 04 & 05
      case 3: // 06
      case 4: // 07
      case 6: // 10
      case 7: // 12
      case 9: // 14

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
        body: ChangeNotifierProvider(
          create: (context) => this._theAdventureData,
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.bottomCenter,
                  child: this.buildCurrentAdventureScreen()),

              //

              if (this._inventoryIsOpen)
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Consumer<AdventureData>(
                        builder: (context, theAdvData, child) =>
                            ExploreaInventory(
                              currentInventory: theAdvData.inventory,
                              itemSelected: theAdvData.selectedItem,
                              onItemSelected: (selectedItem) {
                                if (selectedItem != null)
                                  theAdvData.selectItem(selectedItem);
                              },
                            )),
                  ),
                ),

              //

              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRect(
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(32.0, 16.0, 16.0, 8.0),
                        child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 10,
                              sigmaY: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Consumer<AdventureData>(
                                  builder: (context, theAdvData, child) =>
                                      ExploreaTimer(
                                    currentTime: theAdvData.currentTime,
                                    borderColor: Colors.white,
                                  ),
                                ),

                                //

                                GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: this._inventoryIsOpen
                                                ? ExploreaColors.yellow
                                                : Colors.white),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        color: Colors.black.withOpacity(0.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4.0),
                                      child: Icon(Icons.backpack_outlined,
                                          color: this._inventoryIsOpen
                                              ? ExploreaColors.yellow
                                              : Colors.white),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      this._inventoryIsOpen =
                                          !this._inventoryIsOpen;
                                    });
                                  },
                                ),

                                //

                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      color: Colors.black.withOpacity(0.0)),
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4.0),
                                      child: Text(
                                        "Indices",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0),
                                      )),
                                ),
                              ],
                            )),
                      ),
                    )
                  ],
                ),
              ),

              //

              if (this._nextBtnIsDisplayed)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: ExploreaBtnNext(
                      onPressed: () {
                        this.runNextScreen();
                      },
                    ),
                  ),
                ),
            ],
          ),
        ));
  }
}
