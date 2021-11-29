import 'dart:developer';

import 'package:exploreapp/explorea_colors.dart';
import 'package:exploreapp/main.dart';
import 'package:exploreapp/pages/adventure_details.dart';
import 'package:exploreapp/pages/interactive_map.dart';
import 'package:exploreapp/pages/profile.dart';
import 'package:exploreapp/src/adventures.dart';
import 'package:exploreapp/wigets/explorea-line.dart';
import 'package:exploreapp/wigets/explorea-note-frame.dart';
import 'package:exploreapp/wigets/explorea-title-secondary.dart';
import 'package:exploreapp/wigets/explorea-title.dart';
import 'package:exploreapp/wigets/explorea_btn_square.dart';
import 'package:exploreapp/wigets/explorea_fab.dart';
import 'package:flutter/material.dart';

class NearAdventures extends StatelessWidget {
  NearAdventures({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisSize: MainAxisSize.max, children: [
        Container(height: 50.0),

        //
        // Upper btns

        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 16.0, 30.0, 0),
              child: Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ExploreaFab(
                      onPressed: () {
                        goToNextPage(context, InteractiveMap());
                      },
                      padding: EdgeInsets.all(8.0),
                      icon: const Icon(Icons.map_outlined),
                    ),
                    Expanded(child: Container()),
                    ExploreaFab(
                      onPressed: () {
                        goToNextPage(context, Profil());
                      },
                      padding: const EdgeInsets.all(8.0),
                      icon: const Icon(Icons.person_outline_sharp),
                    ),
                    ExploreaFab(
                      onPressed: () {},
                      padding: const EdgeInsets.all(8.0),
                      icon: const Icon(Icons.filter_alt_outlined),
                    ),
                    ExploreaFab(
                      onPressed: () {},
                      padding: const EdgeInsets.all(8.0),
                      icon: const Icon(Icons.search),
                    ),
                  ],
                ),
              ),
            ),

            // Upper btns
            //

            Container(height: 30.0),

            //
            // Le title

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExploreaTitleSecondary(text: "Les parcours"),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 6.0, 0.0),
                        child: ExploreaLine(
                          width: 40.0,
                          color: ExploreaColors.yellow,
                        ),
                      ),
                      ExploreaTitleSecondary(text: "près de chez")
                    ],
                  ),
                  ExploreaTitleSecondary(text: "vous")
                ],
              ),
            ),

            // Le title
            //

            Container(
              height: 20.0,
            ),

            //
            // The adventures

            Container(
              height: 400.0,
              child: buildAdventuresList(context),
            ),

            // The adventures
            //
          ],
        )
      ]),
    );
  }
}

ListView buildAdventuresList(context) {
  List<Widget> adventuresWidgets = [];

  ListView ret =
      ListView(scrollDirection: Axis.horizontal, children: adventuresWidgets);

  for (var anAdventure in allAdventures) {
    adventuresWidgets.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ExploreaNoteFrame(
          backgroundAsset: anAdventure.backgroundPict != null
              ? anAdventure.backgroundPict
              : null, // Default is purple.
          width: 300.0,
          height: 300.0,
          child: Wrap(
            runAlignment: WrapAlignment.end,
            children: [
              Text(
                anAdventure.name,
                style: TextStyle(fontSize: 24.0, color: Colors.white),
              ),
              Container(height: 10.0),
              Row(
                children: [
                  Text(
                    anAdventure.difficultyText,
                    style: TextStyle(fontSize: 15.0, color: Colors.white),
                  ),
                  Container(
                    width: 20,
                  ),
                  Icon(
                    Icons.access_time_outlined,
                    color: Colors.white,
                  ),
                  Text(
                    " ${anAdventure.supposedTime} min",
                    style: TextStyle(fontSize: 15.0, color: Colors.white),
                  )
                ],
              ),
              Container(height: 30.0),
              Text(
                anAdventure.description.substring(0, 120) + "...",
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
              Container(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ExploreaBtnSquare(
                    text: "Consulter",
                    paddingHorizontal: 80.0,
                    onPressed: () {
                      log("clic on ${anAdventure.name}");
                      goToNextPage(context,
                          AdventureDetails(adventureId: anAdventure.id));
                    },
                    backgroundColor: Colors.white,
                    textColor: ExploreaColors.purpleDark,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  return ret;
}
