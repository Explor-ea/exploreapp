import 'package:exploreapp/wigets/explorea_fab.dart';
import 'package:flutter/material.dart';

import '../explorea_colors.dart';

class Profil extends StatelessWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ExploreaFab(
                onPressed: () {},
                padding: const EdgeInsets.all(8.0),
                icon: const Icon(Icons.settings),
              ),
              ExploreaFab(
                onPressed: () {
                  Navigator.pop(context);
                },
                padding: const EdgeInsets.all(8.0),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Image.asset("assets/explorea-no_pict.png"),
                  Text("New User")
                ],
              ))
        ],
      ),
    );
  }
}
