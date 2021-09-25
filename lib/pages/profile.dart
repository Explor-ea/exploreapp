import 'dart:math';

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
                  Image.asset(
                    "assets/explorea-no_pict.png",
                    height: 128.0,
                    width: 128.0,
                  ),
                  Text("New User"),
                ],
              )),
          SizedBox(height: 28.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Consumer<ApplicationState>(
                builder: (context, appState, _) => Authentification(
                    loginState: appState.loginState,
                    email: appState.email,
                    startLoginFlow: appState.startLoginFlow,
                    verifyEmail: appState.verifyEmail,
                    signInWithEmailAndPassword:
                        appState.signInWithEmailAndPassword,
                    cancelRegistration: appState.cancelRegistration,
                    registerAccount: appState.registerAccount,
                    signOut: appState.signOut),
              ),
            ],
          ),
          SizedBox(height: 28.0),
          Row(
            children: [Text("Mes parcours accomplis")],
          ),
          buildScenarioList(),
          SizedBox(height: 28.0),
          Row(
            children: [Text("Mes récompenses")],
          ),
          buildScenarioList(),
        ],
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
