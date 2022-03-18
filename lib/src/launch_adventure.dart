import 'dart:developer';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:exploreapp/main.dart';
import 'package:exploreapp/pages/adventures/adventure_1_gulls.dart';
import 'package:exploreapp/src/navigation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

launchAdventure(int adventureId, BuildContext context) async {
  // Veriffy that the user is connected
  // then verify that he can launch this adventure by requested it's `allowedScenario`
  // if this is allowed, Navigator push the corresponding Adventure Widget page.

  Widget? nextPageWidget;
  switch (adventureId) {
    case 1:
      assetFileName = "adventure_1_gulls";

      nextPageWidget = Adventure1Gulls();
      break;

    default:
      goToNextPage(
          context, ErrorWidget(Exception("Impossible de lancer le scénario.")));
      return false;
  }

  // Make sure the assets are downloaded then start the adventure !
  // _downloadAssets(assetFileName!).then((nothing) {});
  await _downloadAssets(assetFileName!);

  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => nextPageWidget!),
      (route) => false);
  // return true;
}

//

//

//

/// The name of the .zip file in Firebase Cloud Storage
String? assetFileName;

/// getApplicationDocumentsDirectory().path
String? _assetsDir; // /data/user/0/fr.explorea.exploreapp/app_flutter

const FIREBASESTORAGE_URL =
    "https://firebasestorage.googleapis.com/v0/b/exploreapp-233637313319425.appspot.com/o";

Future<void> _downloadAssets(String name) async {
  if (_assetsDir == null) {
    _assetsDir = (await getApplicationDocumentsDirectory()).path;
  }
  if (_assetsDir == null)
    return;

  //

  else {
    var thedir = new Directory(_assetsDir! + '/');
    var filelist = thedir.listSync(recursive: true);
    print(filelist);

    if (_hasToDownloadAssets(name, _assetsDir!) == false) {
      // var allFiles =
      //     io.Directory(_assetsDir! + '/' + name).listSync(recursive: true);
      // log(allFiles.toString());

      return;
    }

    // TODO: show download toast.

    var zippedFile = await _downloadFile(
        '$FIREBASESTORAGE_URL/$name.zip?alt=media&token=df8ba105-3536-47dd-b2e0-47b3401bc077',
        '$name.zip',
        _assetsDir!);

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
