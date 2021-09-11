import 'dart:html';

import 'package:exploreapp/pages/interactive_map.dart';
import 'package:flutter/material.dart';

import '../../pass_points.dart';

class Cinematic extends StatelessWidget {
  const Cinematic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
