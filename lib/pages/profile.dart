import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploreapp/pages/settings/cgu.dart';
import 'package:exploreapp/pages/settings/cgv.dart';
import 'package:exploreapp/pages/settings/personal_infos.dart';
import 'package:exploreapp/wigets/explorea-line.dart';
import 'package:exploreapp/wigets/explorea-note-frame.dart';
import 'package:exploreapp/wigets/explorea_goto_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:exploreapp/wigets/explorea_fab.dart';
import 'package:provider/single_child_widget.dart';
import '../explorea_colors.dart';

import 'package:exploreapp/main.dart';
import 'package:exploreapp/src/authentification.dart';
import "package:provider/provider.dart";

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  String sinceTxt = "";

  @override
  void initState() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      this.sinceTxt =
          (DateTime.now().difference(currentUser.metadata.creationTime!).inDays)
                  .toString() +
              " jours";
    }
  }

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

            Container(height: 30),

            Text("Welcome",
                style: TextStyle(fontSize: 38, color: ExploreaColors.purple)),
            Row(
              children: [
                ExploreaLine(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                ),
                // // TODO: mettre le nom
                // Text("METTRE LE NOM")
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text("Membre depuis " + sinceTxt)],
            ),

            Container(height: 30),

            Expanded(
              child: DefaultTabController(
                  initialIndex: 1,
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: ExploreaColors.purple,
                        unselectedLabelColor: ExploreaColors.darkGrey,
                        //
                        labelStyle: TextStyle(
                            color: ExploreaColors.purple, fontSize: 20.0),
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
                      Container(height: 40),
                      Expanded(
                        child: TabBarView(children: [
                          //
                          // 'Statistiques' tab
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
                          // 'Statistiques' tab
                          //

                          //
                          // 'Réglages' tab
                          Container(
                            child: buildSettingsList(),
                          )
                          // 'Réglages' tab
                          //
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

  Widget buildSettingsList() {
    var items = [
      <Widget>[
        Text(
          "?",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        Text(
          "F.A.Q",
          style: TextStyle(color: ExploreaColors.purple, fontSize: 24.0),
        ),
        ExploreaGotoIcon()
      ],
      [
        Icon(
          Icons.phone_android,
          color: Colors.white,
        ),
        Text(
          "C.G.U",
          style: TextStyle(color: ExploreaColors.purple, fontSize: 24.0),
        ),
        ExploreaGotoIcon(
          nextPage: Cgu(),
        )
      ],
      [
        Icon(
          Icons.people_outline,
          color: Colors.white,
        ),
        Text(
          "C.G.V",
          style: TextStyle(color: ExploreaColors.purple, fontSize: 24.0),
        ),
        ExploreaGotoIcon(
          nextPage: Cgv(),
        )
      ],
      [
        Icon(
          Icons.person,
          color: Colors.white,
        ),
        Text(
          "Infos",
          style: TextStyle(color: ExploreaColors.purple, fontSize: 24.0),
        ),
        ExploreaGotoIcon(
          nextPage: PersonalInfos(),
        )
      ]
    ];

    List<Widget> itemList = [];

    for (int i = 0; i < items.length; i++) {
      var anItem = items[i];

      itemList.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ExploreaNoteFrame(
            width: 60,
            height: 60,
            padding: EdgeInsets.zero,
            child: Center(child: anItem[0]),
          ),
          anItem[1],
          anItem[2],
        ],
      ));

      if (i < items.length - 1)
        itemList.add(Divider(
          height: 26.0,
          color: ExploreaColors.purple,
        ));
    }

    return Column(
      children: itemList,
    );
  }
}
