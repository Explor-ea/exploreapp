// import 'dart:html';

import 'dart:async';

import 'package:exploreapp/pages/interactive_map.dart';
import 'package:exploreapp/src/navigation.dart';
import 'package:flutter/material.dart';
import 'package:exploreapp/main.dart';

import '../../pass_points.dart';

class Cinematic extends StatelessWidget {
  const Cinematic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 1), () async {
      goToNextPage(context, InteractiveMap());
    });

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Expanded(
              flex: 1,
              child: Row(
                children: [
                  // TODO: replace text by a cinematic.
                  Text(
                    "Ptite cinématic",
                  ),
                ],
              )),
          Expanded(
            flex: 5,
            child: Column(),
          ),
          SizedBox(height: 16.0),
          PassPoints(nbPoints: 0, nextPage: InteractiveMap()),
        ],
      ),
    ));
  }
}
