import 'dart:async';

import 'package:exploreapp/explorea_colors.dart';
import 'package:exploreapp/pages/start_screens/cinematic.dart';
import 'package:exploreapp/pages/start_screens/newcomer.dart';
import 'package:exploreapp/pages/start_screens/newcomer/home.dart';
import 'package:exploreapp/pages/start_screens/newcomer/stepper/custom_ad_agreement.dart';
import 'package:exploreapp/pages/start_screens/newcomer/stepper/data_agreement.dart';
import 'package:exploreapp/pages/start_screens/newcomer/stepper/permissions_agreement.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      bool? dataAgreed = prefs.getBool("dataAgreed");
      bool? adAgreed = prefs.getBool("adAgreed");
      bool? geoAgreed = prefs.getBool("geoAgreed");
      bool? cameraAgreed = prefs.getBool("cameraAgreed");
      bool? microphoneAgreed = prefs.getBool("microphoneAgreed");

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => Newcomer()));

      // if (dataAgreed != null && dataAgreed) {
      //   if (adAgreed != null && adAgreed) {
      //     if (geoAgreed != null &&
      //         geoAgreed &&
      //         cameraAgreed != null &&
      //         cameraAgreed &&
      //         microphoneAgreed != null &&
      //         microphoneAgreed) {
      //       Navigator.of(context).pushReplacement(MaterialPageRoute(
      //           builder: (BuildContext context) => Cinematic()));
      //     } else {
      //       Navigator.of(context).pushReplacement(MaterialPageRoute(
      //           builder: (BuildContext context) => PermissionsAgreement()));
      //     }
      //   } else {
      //     Navigator.of(context).pushReplacement(MaterialPageRoute(
      //         builder: (BuildContext context) => CustomDateAgreement()));
      //   }
      // // } else {
      //   Navigator.of(context).pushReplacement(MaterialPageRoute(
      //       builder: (BuildContext context) =>
      //           // DataAgreement()
      //           Home()));
      // }
    });

    return Scaffold(
      backgroundColor: ExploreaColors.yellow,
      body: Center(
        child: Image.asset(
          "assets/icon/explorea-logo.png",
          height: 223,
          width: 223,
        ),
      ),
    );
  }
}
