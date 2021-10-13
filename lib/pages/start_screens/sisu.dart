import 'dart:developer';

import 'package:exploreapp/explorea_colors.dart';
import 'package:exploreapp/main.dart';
import 'package:exploreapp/pages/start_screens/cinematic.dart';
import 'package:exploreapp/src/authentification.dart';
import 'package:exploreapp/wigets/explorea-text.dart';
import 'package:exploreapp/wigets/explorea-title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Sisu extends StatelessWidget {
  final ApplicationLoginState loginState;
  final String? email;

  const Sisu({
    Key? key,
    required this.loginState,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("dans le builddu Sisu");

    return new Scaffold(
        backgroundColor: ExploreaColors.yellow,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/icon/explorea-logo.png",
                        height: 81,
                        width: 81,
                      ),
                    ),
                    buildTitle(),
                    Text("juste,test"),
                    Text(this.loginState.toString()),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  child: Consumer<ApplicationState>(
                    builder: (context, appState, _) => Authentification(
                      loginState: appState.loginState,
                      email: appState.email,
                      startLoginFlow: appState.startLoginFlow,
                      verifyEmail: appState.verifyEmail,
                      signInWithEmailAndPassword:
                          appState.signInWithEmailAndPassword,
                      cancelRegistration: appState.cancelRegistration,
                      registerAccount: appState.registerAccount,
                      signOut: appState.signOut,

                      //
                      nextPage: Cinematic(),
                    ),
                  ),
                ),
              ),
              // Container(
              //   height: 80.0,
              // )
            ],
          ),
        ));

    /*
  TODO: Rediriger un moment vers : 
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => Cinematic()));

  */
  }

  Widget buildTitle() {
    log("dans le buildtitle");
    log(this.loginState.toString());

    switch (this.loginState) {
      case ApplicationLoginState.register:
        return new ExploreaTitle(text: "Inscription");

        break;
      case ApplicationLoginState.loggedIn:
        log("dans le loggedIn");
        return new Column(
          children: [
            ExploreaTitle(text: "Connecté"),
            ExploreaText(text: this.email ?? "?"),
          ],
        );

        break;

      default:
        return new ExploreaTitle(text: "Connexion");
    }
  }
}
