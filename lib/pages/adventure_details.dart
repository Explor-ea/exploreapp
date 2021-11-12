import 'package:exploreapp/explorea_colors.dart';
import 'package:exploreapp/main.dart';
import 'package:exploreapp/pages/profile.dart';
import 'package:exploreapp/src/adventure_model.dart';
import 'package:exploreapp/src/adventures.dart';
import 'package:exploreapp/wigets/explorea_fab.dart';
import 'package:flutter/material.dart';
import "dart:math" as math;

class AdventureDetails extends StatelessWidget {
  final int adventureId;

  const AdventureDetails({Key? key, required this.adventureId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Adventure theAdventure =
        allAdventures.firstWhere((element) => element.id == this.adventureId);
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: theAdventure.backgroundPict != null
                    ? DecorationImage(
                        image: AssetImage(theAdventure.backgroundPict!),
                        fit: BoxFit.cover)
                    : null,
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTapDown: (unusedDetails) {
                            goBack(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "<<",
                                style: TextStyle(color: ExploreaColors.yellow),
                              ),
                              Text(
                                " Retour",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        ExploreaFab(
                          onPressed: () {
                            goToNextPage(context, Profil());
                          },
                          padding: const EdgeInsets.all(8.0),
                          icon: const Icon(
                            Icons.person_outline_sharp,
                            color: ExploreaColors.purple,
                          ),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 0, 40, 0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            theAdventure.name,
                            style:
                                TextStyle(fontSize: 64.0, color: Colors.white),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 50, 0, 30),
                            child: Transform.rotate(
                                angle: 270 * math.pi / 180,
                                child: Icon(
                                  Icons.chevron_left,
                                  color: ExploreaColors.yellow,
                                )),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 180,
                  //
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            theAdventure.difficultyText,
                            style: TextStyle(
                                fontSize: 15.0,
                                color: ExploreaColors.purpleDark),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_outlined,
                                color: ExploreaColors.yellow,
                              ),
                              Text(
                                " ${theAdventure.supposedTime} min",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: ExploreaColors.purpleDark),
                              )
                            ],
                          )
                        ],
                      ),
                      Container(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person_outline,
                                color: ExploreaColors.yellow,
                              ),
                              Text(
                                " +${theAdventure.ageRestriction} ans",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: ExploreaColors.purpleDark),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.accessible_forward,
                                color: ExploreaColors.yellow,
                              ),
                              Text(
                                theAdventure.suitableForDisabledPeople
                                    ? "Adapté"
                                    : "Non adapté",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: ExploreaColors.purpleDark),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
