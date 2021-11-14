import 'dart:math';

import 'package:exploreapp/wigets/explorea-line.dart';
import 'package:flutter/material.dart';

import 'package:exploreapp/wigets/explorea_fab.dart';
import '../explorea_colors.dart';

import 'package:exploreapp/main.dart';
import 'package:exploreapp/src/authentification.dart';
import "package:provider/provider.dart";

class Profil extends StatelessWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ExploreaFab(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    padding: const EdgeInsets.all(8.0),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     Consumer<ApplicationState>(
            //       builder: (context, appState, _) => Authentification(
            //           loginState: appState.loginState,
            //           email: appState.email,
            //           startLoginFlow: appState.startLoginFlow,
            //           verifyEmail: appState.verifyEmail,
            //           signInWithEmailAndPassword:
            //               appState.signInWithEmailAndPassword,
            //           cancelRegistration: appState.cancelRegistration,
            //           registerAccount: appState.registerAccount,
            //           signOut: appState.signOut),
            //     ),
            //   ],
            // ),

            Container(
              height: 50,
            ),

            Text("Welcome"),
            Row(
              children: [
                ExploreaLine(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                ),
                // TODO: mettre le nom
                Text("METTRE LE NOM")
              ],
            ),

            Container(
              height: 50,
            ),

            Expanded(
              child: DefaultTabController(
                  initialIndex: 1,
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: ExploreaColors.purpleDark,
                        unselectedLabelColor: ExploreaColors.darkGrey,
                        //
                        labelStyle: TextStyle(
                            color: ExploreaColors.purpleDark, fontSize: 20.0),
                        unselectedLabelStyle:
                            TextStyle(color: ExploreaColors.darkGrey),
                        //
                        //
                        indicatorColor: ExploreaColors.yellow,
                        //
                        //
                        tabs: [
                          Tab(text: "Statistiques"),
                          Tab(text: "Réglages"),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(children: [
                          Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [Text("Mes parcours accomplis")],
                                ),
                                buildScenarioList(),
                                Container(height: 28.0),
                                Row(
                                  children: [Text("Mes récompenses")],
                                ),
                                buildScenarioList(),
                              ],
                            ),
                          ),
                          Container(
                            child: Text("tab 2"),
                          )
                        ]),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildScenarioList() {
    List<Widget> scenarioList = [];

    for (var i = 0; i < Random().nextInt(6) + 2; i++) {
      scenarioList.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
            width: 220.0,
            child: Row(
              children: [
                Container(
                  color: Colors.black,
                  height: 80,
                  width: 80,
                ),
                Text("Nom du parcours")
              ],
            ),
            color: Colors.grey),
      ));
    }

    return Container(
      height: 150.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: scenarioList,
      ),
    );
  }
}
