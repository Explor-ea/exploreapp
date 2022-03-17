import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:archive/archive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploreapp/explorea_colors.dart';
import 'package:exploreapp/pages/adventure_details.dart';
import 'package:exploreapp/src/navigation.dart';
import 'package:exploreapp/src/permissions.dart';
import 'package:exploreapp/wigets/explorea-note-frame.dart';
import 'package:exploreapp/wigets/explorea_btn_next.dart';
import 'package:exploreapp/wigets/explorea_inventory.dart';
import 'package:exploreapp/wigets/explorea_notification_frame.dart';
import 'package:exploreapp/wigets/explorea_throwable_container.dart';
import 'package:exploreapp/wigets/explorea_timer.dart';
import 'package:exploreapp/wigets/explorea_tips_frame.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:video_player/video_player.dart';
import 'package:geolocator/geolocator.dart';

class AdventureData extends ChangeNotifier {
  static const List<String> ADVENTURE_SCREENS = [
    "SCREEN01.mp4", // 00
    "SCREEN02.mp4",
    "SCREEN03_04_05.mp4", // 02
    "SCREEN06.mp4",
    "SCREEN07.mp4", // 04
    "SCREEN08_09.mp4",
    "SCREEN10.mp4", // 06
    "SCREEN12.mp4",
    "SCREEN13.mp4", // 08
    "SCREEN14.mp4",
    "SCREEN15.mp4", // 10
    "SCREEN16.mp4",
    "SCREEN17.mp4", // 12
    "SCREEN18.mp4",
    // "SCREEN19.png", // 14
    "SCREEN19.mp4", // 14
    "SCREEN20.mp4",
    "SCREEN22.mp4", // 16
    "SCREEN23.mp4",
    "SCREEN24.mp4", // 18
    "SCREEN26.mp4",
    "SCREEN27.mp4", // 20
    "SCREEN28.mp4",
    "SCREEN29.mp4", // 22
    "SCREEN31.mp4",
    "SCREEN32.mp4", // 24
    "SCREEN33.mp4",
    "SCREEN34.mp4", // 26
    "SCREEN35.mp4",
    "SCREEN36.mp4", // 28
    "SCREEN37.mp4",
  ];

  /// A bunch of adventure params to move through the adventure.
  ///
  /// Note: Although a final object cannot be modified, its fields can be changed. In comparison, a const object and its fields cannot be changed: they're immutable.
  final Map<String, dynamic> adventureParams = {
    "screen2_continue": false,
    "nothing": 5,

    /// Set to true if the user is near [48.0485911,-1.7421397]
    "near_eiffel": false,
    "found_eiffel": false,

    /// Selection from the inventory.
    "selected_item": null,

    /// Composed of "#" 0 or 1, the correct code is : "".
    "self_destruct_enterred_code": [7, 7, 7, 7],

    /// Decide wich tip is discovered.
    "tips_unlocked": [false, false, false, false],

    ///
    "end_the_adventure": false,
    "display_end_btn": false,
  };

  static const List<String> TIPS_LIST = [
    """
L'homme en question ne se trouve pas physiquement autour de vous. 

Avez-vous pensé à tourner sur vous-même ? La dame de fer est parisienne.
    """, // Screen 8
    """
Les couleurs seront votre guide.
A quoi sert le portail ?
Associez les bonnes couleurs et pictos.
    """, // Screen 22
    """
Regardez de près !
Un code vous sera nécessaire ensuite.
    """, // Screen 26
    """
Et si l'indice n'était pas dans la dimension Z ?
Toutes les formes sont dans la nature.
Regardez attentivement les arbres autour de vous.
    """, // Scren 27
  ];

  //
  // Timer

  int currentTime = (60 * 15);

  decrementTimer() {
    currentTime--;
    notifyListeners();
  }

  decrementTimerBy(int decrementBy) {
    if (this.currentTime - decrementBy >= 0)
      this.currentTime -= decrementBy;
    else
      this.currentTime = 0;
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

  String removeItem(String itemId) {
    this.inventory.remove(itemId);

    notifyListeners();

    return itemId;
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
      case "fish_green":
        return "assets/adventure_1_gulls/items/fish_green.png";

      default:
        return null;
    }
  }

  // Inventory
  //

  //
  // Self destruct code

  /// Add a number to the code the user is gessing.
  /// If the number match the destruction code, the next screen should be run.
  ///
  /// @return `true` the current guessed code matches the self-destruction code, else `false`.
  addToCurrentCode(int number) {
    /// [0, 0, 1, 1] but reversed.
    const List<int> CORRECT_DESTRUCTION_CODE = [1, 1, 0, 0];

    List<int> currentCode = this.adventureParams["self_destruct_enterred_code"];

    currentCode.insert(0, number);

    while (currentCode.length > CORRECT_DESTRUCTION_CODE.length) {
      currentCode.removeLast();
    }

    log(currentCode.toString());

    return ListEquality().equals(currentCode, CORRECT_DESTRUCTION_CODE);
  }

  // Self destruct code
  //

  /// Zero based index, references `AdventureData.ADVENTURE_SCREENS`
  int currentScreen = 0;
}

// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------

/// TODO: all paths like "assets/*" must be replaced with dynamic assets path
/// TODO: Show a message when downloading assets
/// TODO: Add btn clic sounds and vibrations, like screen changes etc .
/// XXX IMPROVE: Factorise code, like looping or not on asset load.
/// XXX MAYBE: Add the screen 30 with the final game.
class Adventure1Gulls extends StatefulWidget {
  const Adventure1Gulls({Key? key}) : super(key: key);

  @override
  _Adventure1GullsState createState() => _Adventure1GullsState();
}

class _Adventure1GullsState extends State<Adventure1Gulls> {
  /// Main videos controller.
  VideoPlayerController? _vpController;
  Future<void>? _initializeVideoPlayerFuture;

  /// Controller for the foreground audio, for the music.
  VideoPlayerController? _vpAudioController;

  bool _nextBtnIsDisplayed = false;

  AdventureData _theAdventureData = new AdventureData();
  Timer? _theAdvTimer;

  var _assetsDir; // /data/user/0/fr.explorea.exploreapp/app_flutter
  static const FIREBASESTORAGE_URL =
      "https://firebasestorage.googleapis.com/v0/b/exploreapp-233637313319425.appspot.com/o";
  static const ASSET_NAME = "adventure_1_gulls";

  final LocationSettings _locationSettings = new LocationSettings(
    accuracy: LocationAccuracy.best,
    distanceFilter: 2,
  );

  bool _inventoryIsOpen = false;
  bool _tipsFrameIsOpen = false;
  bool _notificationTimeIsUpIsOpen = false;
  bool _notificationWrongFishIsOpen = false;
  bool _notificationWrongContainerIsOpen = false;

  @override
  void initState() {
    super.initState();

    this.initialiseAudioController();

    // If somehow the location permission has not been agreed, display an error Widget.
    checkAndAskPosition().then((permission) {
      if (permission.index < 2) {
        setState(() {
          this._theAdventureData.currentScreen = 9000;
        });
      }
    });

    // Make sure the assets are downloaded then start the adventure !
    this._downloadAssets().then((nothing) {
      //

      // Start the chrono !
      this._theAdvTimer = Timer.periodic(Duration(seconds: 1), (advTimer) {
        if (this._theAdventureData.currentTime > 0)
          this._theAdventureData.decrementTimer();
        else {
          advTimer.cancel();
          setState(() {
            this._notificationTimeIsUpIsOpen = true;
          });
        }
      });

      //

      // Start the game !
      this.runScreen_1();
    });
  }

  // Future<void> _downloadAssets() async {
  //   if (this._assetsDir == null)
  //     this._assetsDir = (await getApplicationDocumentsDirectory()).path;

  //   if (!(await File(this._assetsDir + '/' + ASSET_NAME + '.zip').exists())) {
  //     var cloudFileRequest = (await Client().get(Uri.parse(
  //         '$FIREBASESTORAGE_URL/$ASSET_NAME.zip?alt=media&token=784e056b-5b58-4835-811f-f8a167c82342')));

  //     var file = File('$_assetsDir/$ASSET_NAME');
  //     var zippedFile = await file.writeAsBytes(cloudFileRequest.bodyBytes);

  //     var archive = ZipDecoder().decodeBytes(zippedFile.readAsBytesSync());

  //     for (var aFile in archive) {
  //       if (aFile.isFile) {
  //         var outFile = File('$_assetsDir/${aFile.name}');
  //         outFile = await outFile.create(recursive: true);
  //         await outFile.writeAsBytes(aFile.content);
  //       }
  //     }
  //   }
  // }

  // Widget _getImage(String name, String dir) {
  //   if (_theme != AppTheme.candy) {
  //     var file = _getLocalImageFile(name, dir);
  //     return Image.file(file);
  //   }
  //   return Image.asset('assets/images/$name');
  // }

  // File _getLocalImageFile(String name, String dir) => File('$dir/$name');

  String getFullAssetPath(String assetPath) =>
      (this._assetsDir + '/' + assetPath);

  Future<void> _downloadAssets({String name = ASSET_NAME}) async {
    if (_assetsDir == null) {
      _assetsDir = (await getApplicationDocumentsDirectory()).path;
    }

    var thedir = new Directory(_assetsDir + '/');
    var filelist = thedir.listSync(recursive: true);
    print(filelist);

    if (_hasToDownloadAssets(name, _assetsDir) == false) {
      // var allFiles =
      //     io.Directory(_assetsDir + '/' + name).listSync(recursive: true);
      // log(allFiles.toString());

      return;
    }

    this.showExploreaToast("Téléchargement du scénario . . .");

    var zippedFile = await _downloadFile(
        '$FIREBASESTORAGE_URL/$name.zip?alt=media&token=df8ba105-3536-47dd-b2e0-47b3401bc077',
        '$name.zip',
        _assetsDir);

    var bytes = zippedFile.readAsBytesSync();
    var archive = ZipDecoder().decodeBytes(bytes);

    for (var file in archive) {
      var filename = '$_assetsDir/${file.name}';
      if (file.isFile) {
        var outFile = File(filename);
        outFile = await outFile.create(recursive: true);
        await outFile.writeAsBytes(file.content);
      }
    }
  }

  bool _hasToDownloadAssets(String name, String dir) {
    var file = File('$dir/$name.zip');
    var itExists = file.existsSync();

    log(itExists.toString());

    return !itExists;
  }

  Future<File> _downloadFile(String url, String filename, String dir) async {
    var req = await Client().get(Uri.parse(url));
    var file = File('$dir/$filename');
    return file.writeAsBytes(req.bodyBytes);
  }

  showExploreaToast(String msg, {double fontSize = 18.0}) {
    final showConfiguredToast = () {
      return Fluttertoast.showToast(
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: ExploreaColors.yellow,
          textColor: ExploreaColors.purple,
          fontSize: fontSize,
          msg: msg);
    };

    HapticFeedback.heavyImpact();
    return showConfiguredToast()
        .then((value) => showConfiguredToast())
        .then((value) => showConfiguredToast());
  }

  bool endTimer() {
    if (this._theAdvTimer != null) {
      this._theAdvTimer!.cancel();
      return true;
    } else
      return false;
  }

  initialiseAudioController() {
    // if (this._vpAudioController != null &&
    //     this._vpAudioController!.value.isInitialized)
    //   await this._vpAudioController!.dispose();

    this._vpAudioController = VideoPlayerController.asset(
        "assets/adventure_1_gulls/sounds/run.mp3",
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));

    this._vpAudioController!.setLooping(true);
  }

  /// After it, [_vpController] is `!= null`.
  void changeCurrentScreenAndLoadAsset(int newCurrentScreen,
      {bool resetNextBtn: true}) {
    if (resetNextBtn) this._nextBtnIsDisplayed = false;

    // XXX CAREFUL: when putted after the asset asignation, makes errors. And it's asynchronous so...
    if (this._vpController !=
        null /* && this._vpController!.value.isInitialized */)
      this._vpController!.dispose();

    this._theAdventureData.currentScreen = newCurrentScreen;
    var fullAssetPath = this.getFullAssetPath(
        AdventureData.ADVENTURE_SCREENS[this._theAdventureData.currentScreen]);
    this._vpController = VideoPlayerController.file(File(fullAssetPath));
    print(this._vpController);
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
      case 13:
        this.runScreen_19();
        break;
      case 14:
        this.runScreen_19();
        break;
      case 15:
        this.runScreen_20();
        break;
      case 16:
        this.runScreen_22();
        break;
      case 17:
        this.runScreen_23();
        break;
      case 18:
        this.runScreen_24();
        break;
      case 19:
        this.runScreen_26();
        break;
      case 20:
        this.runScreen_27();
        break;
      case 21:
        this.runScreen_28();
        break;
      case 22:
        this.runScreen_29();
        break;
      case 23:
        this.runScreen_31();
        break;
      case 24:
        this.runScreen_32();
        break;
      case 25:
        this.runScreen_33();
        break;
      case 26:
        this.runScreen_34();
        break;
      case 27:
        this.runScreen_35();
        break;
      case 28:
        this.runScreen_36();
        break;
      case 29:
        this.runScreen_37();
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

  /// The rat talks in rat.
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

  /// The rat is warning the player.
  void runScreen_6() {
    this.changeCurrentScreenAndLoadAsset(3);

    this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      this._vpController!.addListener(() {
        if (this._vpController!.value.position ==
            this._vpController!.value.duration) {
          setState(() {
            this._nextBtnIsDisplayed = true;
          });
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

  /// Did you find the man of the Dame de fer ?
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
            // XXX MAYBE: this should be set when the user is geologically near the point.
            this._theAdventureData.adventureParams["near_eiffel"] = true;
          });
        }
      });

      StreamSubscription<Position>? positionStream;
      positionStream =
          Geolocator.getPositionStream(locationSettings: _locationSettings)
              .listen((Position? currentPosition) {
        if (currentPosition != null) {
          const pointCoordinates = [48.048820720263095, -1.7414750135353614];
          double distanceFromThePoint = Geolocator.distanceBetween(
              pointCoordinates[0],
              pointCoordinates[1],
              currentPosition.latitude,
              currentPosition.longitude);

          if (distanceFromThePoint <= 30 /* metters */) {
            this.runScreen_10();
            positionStream!.cancel();
          }
        }
      });
    });

    // Unlock first tip
    this._theAdventureData.adventureParams["tips_unlocked"][0] = true;
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
            this.runScreen_12();
            positionStream!.cancel();
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

    this._vpController!.setLooping(true);

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
    this.changeCurrentScreenAndLoadAsset(14);

    this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      this._vpController!.addListener(() {
        if (this._vpController!.value.position ==
            this._vpController!.value.duration) {}
      });
    });

    // this._vpController!.setLooping(false);
  }

  /// In front of the sign  confirmation.
  void runScreen_20() {
    this.changeCurrentScreenAndLoadAsset(15);

    this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      this._vpController!.addListener(() {
        if (!this._nextBtnIsDisplayed &&
            this._vpController!.value.position >= const Duration(seconds: 3)) {
          setState(() {
            this._nextBtnIsDisplayed = true;
          });
        }
      });
    });
  }

  /// Alternate dimension sign.
  void runScreen_22() {
    this.changeCurrentScreenAndLoadAsset(16);

    this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      this._vpController!.addListener(() {
        if (!this._nextBtnIsDisplayed &&
            this._vpController!.value.position >= const Duration(seconds: 4)) {
          setState(() {
            this._nextBtnIsDisplayed = true;
          });
        }
      });
    });

    // Unlock tip.
    this._theAdventureData.adventureParams["tips_unlocked"][1] = true;
  }

  /// Chose the good container.
  void runScreen_23() {
    this.changeCurrentScreenAndLoadAsset(17);

    this._vpController!.setLooping(true);

    this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      this._vpController!.addListener(() {
        if (this._vpController!.value.position ==
            this._vpController!.value.duration) {}
      });
    });
  }

  /// Nice done screen, ask to go to the container.
  void runScreen_24() {
    this.changeCurrentScreenAndLoadAsset(18);

    this._vpController!.setLooping(false);

    this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      this._vpController!.addListener(() {
        if (this._vpController!.value.position ==
            this._vpController!.value.duration) {
          this._vpController!.seekTo(Duration(seconds: 6)).then((nothing) {
            this._vpController!.play();
          });
        }
      });

      StreamSubscription<Position>? positionStream;
      this._vpController!.addListener(() {
        if (positionStream == null &&
            this._vpController!.value.position > const Duration(seconds: 3)) {
          // Run the next screen when arrived at the point.
          positionStream =
              Geolocator.getPositionStream(locationSettings: _locationSettings)
                  .listen((Position? currentPosition) {
            if (currentPosition != null) {
              // The coordinates are a little far from the desired point, this allows with a large distance from the point to make the user go to the south but to let him find the point more easely.
              const pointCoordinates = [48.048222, -1.742571];
              double distanceFromThePoint = Geolocator.distanceBetween(
                  pointCoordinates[0],
                  pointCoordinates[1],
                  currentPosition.latitude,
                  currentPosition.longitude);

              if (distanceFromThePoint <= 25 /* metters */) {
                positionStream!.cancel();

                this.runScreen_26();
              }
            }
          });
        }
      });
    });
  }

  /// Inside the generator.
  void runScreen_26() {
    this.changeCurrentScreenAndLoadAsset(19);

    this._vpController!.setLooping(false);

    this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      this._vpController!.addListener(() {
        if (this._vpController!.value.position ==
            this._vpController!.value.duration) {
          this._vpController!.seekTo(Duration(seconds: 2)).then((nothing) {
            this._vpController!.play();
          });
        }
      });
    });

    // Unlock tip.
    this._theAdventureData.adventureParams["tips_unlocked"][2] = true;
  }

  /// Console interraction.
  void runScreen_27() {
    this.changeCurrentScreenAndLoadAsset(20);

    this._vpController!.setLooping(true);

    this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      // this._vpController!.addListener(() {
      //   if (this._vpController!.value.position ==
      //       this._vpController!.value.duration) {}
      // });
    });

    // Unlock tip.
    this._theAdventureData.adventureParams["tips_unlocked"][3] = true;
  }

  /// Auto destruction in progress.
  void runScreen_28() {
    this.changeCurrentScreenAndLoadAsset(21);

    this._vpController!.setLooping(false);

    this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      this._vpController!.addListener(() {
        if (this._vpController!.value.position ==
            this._vpController!.value.duration) {
          this.runScreen_29();
        }
      });
    });
  }

  /// Countdown for the leek.
  void runScreen_29() {
    this.changeCurrentScreenAndLoadAsset(22);

    this._vpController!.setLooping(false);

    this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      this._vpController!.addListener(() {
        if (this._vpController!.value.position ==
            this._vpController!.value.duration) {
          this.runScreen_30();
        }
      });
    });

    //

    this._vpAudioController!.initialize().then((nothing) {
      this._vpAudioController!.play();

      setState(() {});
    });
  }

  /// The end game.
  void runScreen_30() {
    this.runScreen_31();
  }

  /// Go ! The way is clear !
  void runScreen_31() {
    this.changeCurrentScreenAndLoadAsset(23);

    this._vpController!.setLooping(true);

    this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      // this._vpController!.addListener(() {
      //   if (this._vpController!.value.position ==
      //       this._vpController!.value.duration) {}
      // });

      //
      //
      //

      // Run the next screen when arrived at the point.
      StreamSubscription<Position>? positionStream;
      positionStream =
          Geolocator.getPositionStream(locationSettings: _locationSettings)
              .listen((Position? currentPosition) {
        if (currentPosition != null) {
          const pointCoordinates = [48.04852, -1.7424216];
          double distanceFromThePoint = Geolocator.distanceBetween(
              pointCoordinates[0],
              pointCoordinates[1],
              currentPosition.latitude,
              currentPosition.longitude);

          if (distanceFromThePoint <= 7 /* metters */) {
            positionStream!.cancel();

            this.runScreen_32();
          }
        }
      });
    });
  }

  /// Leave the dimension through the portal.
  void runScreen_32() {
    this.changeCurrentScreenAndLoadAsset(24);

    this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      this._vpController!.addListener(() {
        if (this._vpController!.value.position ==
            this._vpController!.value.duration) {
          this.runScreen_33();
        }
      });
    });
  }

  /// So, did you make it ?
  void runScreen_33() {
    this.endTimer();

    this.changeCurrentScreenAndLoadAsset(25);

    this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      this._vpAudioController!.pause();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      this._vpController!.addListener(() {
        if (this._vpController!.value.position >= const Duration(seconds: 2)) {
          setState(() {
            this._nextBtnIsDisplayed = true;
          });
        }
      });
    });
  }

  /// The gate closes.
  void runScreen_34() {
    this.changeCurrentScreenAndLoadAsset(26);
    this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      this._vpController!.addListener(() {
        if (this._vpController!.value.position ==
            this._vpController!.value.duration) {
          this.runScreen_35();
        }
      });
    });
  }

  /// Quest validation, but . . .
  void runScreen_35() {
    this.changeCurrentScreenAndLoadAsset(27);
    this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      this._vpController!.addListener(() {
        if (this._vpController!.value.position ==
            this._vpController!.value.duration) {
          this.runScreen_36();
        }
      });
    });
  }

  /// The rats are invading.
  void runScreen_36() {
    this.changeCurrentScreenAndLoadAsset(28);
    this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      this._vpController!.addListener(() {
        if (this._vpController!.value.position ==
            this._vpController!.value.duration) {
          this.runScreen_37();
        }
      });
    });
  }

  /// Thanks.
  void runScreen_37() {
    this.changeCurrentScreenAndLoadAsset(29);

    this._vpController!.initialize().then((nothing) {
      this._vpController!.play();

      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      this._vpController!.addListener(() {
        if (this._vpController!.value.position >= const Duration(seconds: 6) &&
            _theAdventureData.adventureParams["end_the_adventure"] == false) {
          this._vpController!.pause();

          setState(() {
            _theAdventureData.adventureParams["display_end_btn"] = true;
          });
        }
      });

      this._vpController!.addListener(() {
        if (this._vpController!.value.position ==
            this._vpController!.value.duration) {
          theEnd();
        }
      });
    });
  }

  /// Save things, leave the adventure.
  void theEnd() async {
    this._vpController!.dispose();
    this._vpAudioController!.dispose();

    // If time is >0 add success .

    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var currentUserDoc =
          FirebaseFirestore.instance.collection("users").doc(user.uid);

      await currentUserDoc.update({
        "playedScenario": FieldValue.arrayUnion([
          {
            "idScenario": 1,
            "playerName": "",

            // /* Pour la sauvegarde :  */
            // "currentTime": this._theAdventureData.currentTime,
            // // "lastPlayedDate": null,
            // "lastStep": null,

            /* Pour les stats : */
            "endDate": DateTime.now(),
            "endTime": this._theAdventureData.currentTime, /* seconds */
          }
        ])
      }).onError((error, stackTrace) {
        showExploreaToast(
            "Une erreur inconnue est survenue pendant la sauvegarde.");
      });
    } else {
      // Should not happen
      await showExploreaToast("Erreur lors de la sauvegarde de fin.");
    }

    // Add this adventure to finished adventures.

    goToNextPage(context, AdventureDetails(adventureId: 1));
  }

  Widget buildCurrentAdventureScreen() {
    Widget ret = Container(
      color: ExploreaColors.purple,
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
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
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
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
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
                          onTapDown: (notUsed) {
                            setState(() {
                              this
                                  ._theAdventureData
                                  .inventory
                                  .add("fish_green");

                              showExploreaToast(
                                  "Les goélands vont ils se régaler...");
                              this.runScreen_14();
                            });
                            log("clic poisson gris");
                          }),
                    ),
                    Expanded(
                      child: GestureDetector(
                          child:
                              Container(color: Colors.black.withOpacity(0.0)),
                          onTapDown: (notUsed) {
                            setState(() {
                              this._theAdventureData.inventory.add("fish_red");

                              showExploreaToast(
                                  "Les goélands vont ils se régaler...");
                              this.runScreen_14();
                            });
                            log("clic poisson rouge");
                          }),
                    ),
                    Expanded(
                      child: GestureDetector(
                          child:
                              Container(color: Colors.black.withOpacity(0.0)),
                          onTapDown: (notUsed) {
                            setState(() {
                              this._theAdventureData.inventory.add("fish_blue");

                              showExploreaToast(
                                  "Les goélands vont ils se régaler...");
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
                          String thrownItem = this
                              ._theAdventureData
                              .removeItem(theAdvData.selectedItem!);

                          if (thrownItem == "fish_red") {
                            this.runScreen_16();
                          } else {
                            setState(() {
                              theAdvData.decrementTimerBy(30);
                              this._notificationWrongFishIsOpen = true;
                              //
                              this.runScreen_16();
                            });
                          }
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
                              image: FileImage(
                                  File(getFullAssetPath("Panorama.png"))))),
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
                              onTapDown: (notUsed) {
                                log("Click on sign.");
                                this.runScreen_20();
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

            // Scroll indicators
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24.0, .0, .0, .0),
                      child: Text(
                        "<",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 48.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(.0, .0, 24.0, .0),
                      child: Text(
                        ">",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 48.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),

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
            // Frame
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: SizedBox.expand(
            //     child: FittedBox(
            //       fit: BoxFit.fitWidth,
            //       child: SizedBox(
            //         height: this._vpController!.value.size.height,
            //         width: MediaQuery.of(context).size.width,
            //         child: VideoPlayer(this._vpController!),
            //       ),
            //     ),
            //   ),
            // ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AspectRatio(
                aspectRatio: 1080 / 300,
                child: VideoPlayer(this._vpController!),
              ),
            ),
          ],
        );
        break;

      case 17: // 23
        ret = Stack(
          children: [
            // Containers video
            Align(
              alignment: Alignment.bottomCenter,
              child: AspectRatio(
                aspectRatio: 9.0 / 16.0,
                child: VideoPlayer(this._vpController!),
              ),
            ),

            // Click handlers.
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                child: FractionallySizedBox(
                  heightFactor: 0.3,
                  child: Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // Container blue.
                        Expanded(
                          flex: 165,
                          child: GestureDetector(
                              child: Container(
                                color: Colors.transparent,
                              ),
                              onTapDown: (notUsed) {
                                _theAdventureData.decrementTimerBy(30);
                                setState(() {
                                  this._notificationWrongContainerIsOpen = true;
                                });
                              }),
                        ),
                        // No container.
                        Expanded(
                          flex: 125,
                          child:
                              GestureDetector(child: Container(), onTap: () {}),
                        ),
                        // Container jaune.
                        Expanded(
                          flex: 130,
                          child: GestureDetector(
                              child: Container(
                                color:
                                    // kDebugMode
                                    //     ? Colors.white.withOpacity(0.5)
                                    //     : Colors.white.withOpacity(0),
                                    Colors.white.withOpacity(0.0),
                              ),
                              onTapDown: (notUsed) {
                                this.runScreen_24();
                              }),
                        ),
                        // Container rouge.
                        Expanded(
                          flex: 215,
                          child: GestureDetector(
                              child: Container(
                                color: Colors.transparent,
                              ),
                              onTapDown: (notUsed) {
                                _theAdventureData.decrementTimerBy(30);
                                setState(() {
                                  this._notificationWrongContainerIsOpen = true;
                                });
                              }),
                        ),
                        // Container vert.
                        Expanded(
                          flex: 362,
                          child: GestureDetector(
                              child: Container(
                                color: Colors.transparent,
                              ),
                              onTapDown: (notUsed) {
                                _theAdventureData.decrementTimerBy(30);
                                setState(() {
                                  this._notificationWrongContainerIsOpen = true;
                                });
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
        break;

      case 19: // 26
        ret = Stack(
          children: [
            // Video
            Align(
              alignment: Alignment.bottomCenter,
              child: AspectRatio(
                aspectRatio: 9.0 / 16.0,
                child: VideoPlayer(this._vpController!),
              ),
            ),

            // Click handler.
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                child: FractionallySizedBox(
                  heightFactor: 0.3,
                  child: Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // No container.
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),

                        // The console.
                        Expanded(
                          flex: 4,
                          child: GestureDetector(
                              child: Container(
                                color: Colors.white.withOpacity(0.0),
                              ),
                              onTapDown: (notUsed) {
                                this.runScreen_27();
                              }),
                        ),

                        // No container.
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
        break;

      case 20: // 27
        ret = Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: AspectRatio(
                aspectRatio: 9.0 / 16.0,
                child: Stack(
                  children: [
                    // Video
                    VideoPlayer(this._vpController!),

                    // Click handler.
                    Column(
                      children: [
                        // Nothing
                        Expanded(flex: 14, child: Container()),

                        // Buttons
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                // No container.
                                Expanded(
                                  flex: 9,
                                  child: Container(),
                                ),

                                // The button "0".
                                Expanded(
                                  flex: 10,
                                  child: GestureDetector(
                                      child: Container(
                                        color: Colors.white.withOpacity(0),
                                      ),
                                      onTapDown: (tapDownDetails) {
                                        // TODO: play tap sound
                                        HapticFeedback.heavyImpact();

                                        if (this
                                            ._theAdventureData
                                            .addToCurrentCode(0))
                                          this.runScreen_28();
                                      }),
                                ),

                                // No container.
                                Expanded(
                                  flex: 5,
                                  child: Container(),
                                ),

                                // The button "0".
                                Expanded(
                                  flex: 10,
                                  child: GestureDetector(
                                      child: Container(
                                        color: Colors.white.withOpacity(0),
                                      ),
                                      onTapDown: (tapDownDetails) {
                                        // TODO: play tap sound
                                        HapticFeedback.heavyImpact();

                                        if (this
                                            ._theAdventureData
                                            .addToCurrentCode(1))
                                          this.runScreen_28();
                                      }),
                                ),

                                // No container.
                                Expanded(
                                  flex: 10,
                                  child: Container(),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Nothing
                        Expanded(flex: 4, child: Container()),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        );
        break;

      case 29: // 37
        ret = Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: AspectRatio(
                aspectRatio: 9.0 / 16.0,
                child: VideoPlayer(this._vpController!),
              ),
            ),
            if (this._theAdventureData.adventureParams["display_end_btn"])
              Align(
                alignment: Alignment.bottomCenter,
                child: AspectRatio(
                  aspectRatio: 9.0 / 16.0,
                  child: Column(
                    children: [
                      Expanded(child: Container()),
                      Expanded(child: Center(
                        child: ExploreaBtnNext(
                          onPressed: () {
                            setState(() {
                              this
                                  ._theAdventureData
                                  .adventureParams["end_the_adventure"] = true;
                              this
                                  ._theAdventureData
                                  .adventureParams["display_end_btn"] = false;

                              this._vpController!.play();
                            });
                          },
                          // text: "Terminer l'aventure.",
                        ),
                      ))
                    ],
                  ),
                ),
              ),
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
        ret = this._vpController != null
            ? AspectRatio(
                aspectRatio: 9.0 / 16.0,
                child: VideoPlayer(this._vpController!),
              )
            : Container();
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
              // VideoPlayer(this._vpAudioController!),

              //

              Stack(
                children: [
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: this.buildCurrentAdventureScreen()),

                  //

                  // Timer
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: AspectRatio(
                        aspectRatio: 9.0 / 16.0,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(.0, 32.0, .0, .0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Consumer<AdventureData>(
                                builder: (context, theAdvData, child) =>
                                    ExploreaTimer(
                                  currentTime: theAdvData.currentTime,
                                  borderColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                ],
              ),

              // Inventory
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

              //
              // Notifications pop-in

              if (this._notificationWrongFishIsOpen)
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: ExploreaNotificationFrame(
                      message:
                          "Oh non ! Vous avez donné un mauvais poisson aux goélands. Ils ne sont pas tout de suite intéressés par ce dernier, vous perdez 30 secondes.",
                      repLeft: "D'accord",
                      onCloseLeft: () {
                        setState(() {
                          this._notificationWrongFishIsOpen = false;
                        });
                      },
                    ),
                  ),
                ),

              //

              if (this._notificationTimeIsUpIsOpen)
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: ExploreaNotificationFrame(
                      message:
                          "Le temps est écoulé ! Souhaitez vous continuer quand même ?",
                      repLeft: "NON",
                      onCloseLeft: () {
                        this.theEnd();
                      },
                      repRight: "OUI !",
                      onCloseRight: () {
                        setState(() {
                          this._notificationTimeIsUpIsOpen = false;
                        });
                      },
                    ),
                  ),
                ),

              //

              if (this._notificationWrongContainerIsOpen)
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: ExploreaNotificationFrame(
                      message:
                          "Mauvais bâtiment ! \r\nCet aller-retour vous coûte 30 secondes !",
                      repLeft: "Essayer un autre",
                      onCloseLeft: () {
                        setState(() {
                          this._notificationWrongContainerIsOpen = false;
                        });
                      },
                    ),
                  ),
                ),

              //

              // Notifications pop-in
              //

              // Tips frame
              if (this._tipsFrameIsOpen)
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Consumer<AdventureData>(
                        builder: (context, theAdvData, child) =>
                            ExploreaTipsFrame(
                              tips: AdventureData.TIPS_LIST,
                              unlockedTips: this
                                  ._theAdventureData
                                  .adventureParams["tips_unlocked"],
                              onClose: () {
                                setState(() {
                                  this._tipsFrameIsOpen = false;
                                });
                              },
                            )),
                  ),
                ),

              //

              // Topbar
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRect(
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
                        child: BackdropFilter(
                            filter: ImageFilter.blur(
                                // sigmaX: 10,
                                // sigmaY: 10,
                                ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 100.0,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: this._inventoryIsOpen
                                                    ? ExploreaColors.yellow
                                                    : Colors.white),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            color:
                                                Colors.black.withOpacity(0.0)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 4.0),
                                          child: Text(
                                            "Inventaire",
                                            style: TextStyle(
                                                color: this._inventoryIsOpen
                                                    ? ExploreaColors.yellow
                                                    : Colors.white,
                                                fontSize: 18.0),
                                          ),
                                        ),
                                      ),
                                      onTapDown: (notUsed) {
                                        HapticFeedback.heavyImpact();

                                        setState(() {
                                          this._inventoryIsOpen =
                                              !this._inventoryIsOpen;
                                        });
                                      },
                                    ),

                                    //

                                    GestureDetector(
                                      onTapDown: (notUsed) {
                                        HapticFeedback.heavyImpact();

                                        setState(() {
                                          this._tipsFrameIsOpen =
                                              !this._tipsFrameIsOpen;
                                        });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 100.0,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: this._tipsFrameIsOpen
                                                    ? ExploreaColors.yellow
                                                    : Colors.white),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            color:
                                                Colors.black.withOpacity(0.0)),
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 4.0),
                                            child: Text(
                                              "Indices",
                                              style: TextStyle(
                                                  color: this._tipsFrameIsOpen
                                                      ? ExploreaColors.yellow
                                                      : Colors.white,
                                                  fontSize: 18.0),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),

                                //
                              ],
                            )),
                      ),
                    )
                  ],
                ),
              ),

              //

              // Next button
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
