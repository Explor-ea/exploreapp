import 'package:exploreapp/explorea_colors.dart';
import 'package:exploreapp/pages/interactive_map.dart';
import 'package:exploreapp/pages/profile.dart';
import 'package:exploreapp/wigets/explorea-line.dart';
import 'package:exploreapp/wigets/explorea-title-secondary.dart';
import 'package:exploreapp/wigets/explorea-title.dart';
import 'package:exploreapp/wigets/explorea_fab.dart';
import 'package:flutter/material.dart';

class NearAdventures extends StatelessWidget {
  const NearAdventures({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 0.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16.0, 0.0, 0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ExploreaFab(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InteractiveMap()));
                        },
                        padding: EdgeInsets.all(8.0),
                        icon: const Icon(Icons.map_outlined),
                      ),
                      Expanded(child: Container()),
                      ExploreaFab(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profil()));
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

              Container(height: 30.0),

              //
              // Le title

              Column(
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
              )

              // Le title
              //
            ],
          ),
        )
      ]),
    );
  }
}
