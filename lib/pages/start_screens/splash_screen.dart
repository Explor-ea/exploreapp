import 'dart:async';

import 'package:exploreapp/pages/start_screens/newcomer/home.dart';
import 'package:flutter/material.dart';

// TODO: display splash screen animation
// TODO: change Duration seconds
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 1),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Home())));

    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Text("SPLASHCREEN"),
      ),
    );
  }
}
