import 'dart:async';

import 'package:exploreapp/pages/start_screens/cinematic.dart';
import 'package:exploreapp/pages/start_screens/newcomer/home.dart';
import 'package:exploreapp/pages/start_screens/newcomer/stepper/custom_ad_agreement.dart';
import 'package:exploreapp/pages/start_screens/newcomer/stepper/data_agreement.dart';
import 'package:exploreapp/pages/start_screens/newcomer/stepper/permissions_agreement.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// TODO: display splash screen animation
// TODO: change Duration seconds
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 1), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      bool? dataAgreed = prefs.getBool("dataAgreed");
      bool? adAgreed = prefs.getBool("adAgreed");
      bool? geoAgreed = prefs.getBool("geoAgreed");
      bool? cameraAgreed = prefs.getBool("cameraAgreed");
      bool? microphoneAgreed = prefs.getBool("microphoneAgreed");

      if (dataAgreed != null && dataAgreed) {
        if (adAgreed != null && adAgreed) {
          if (geoAgreed != null &&
              geoAgreed &&
              cameraAgreed != null &&
              cameraAgreed &&
              microphoneAgreed != null &&
              microphoneAgreed) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => Cinematic()));
          } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => PermissionsAgreement()));
          }
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => CustomDateAgreement()));
        }
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) =>
                // DataAgreement()
                Home()));
      }
    });

    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Text("SPLASHCREEN"),
      ),
    );
  }
}
