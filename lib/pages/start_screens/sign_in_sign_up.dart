import 'package:exploreapp/explorea_colors.dart';
import 'package:exploreapp/main.dart';
import 'package:exploreapp/pages/start_screens/cinematic.dart';
import 'package:exploreapp/wigets/explorea-text.dart';
import 'package:exploreapp/wigets/explorea-title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:exploreapp/src/authentification.dart';

class SignInSignUp extends StatefulWidget {
  final ApplicationLoginState loginState;
  final String? email;

  const SignInSignUp({
    Key? key,
    required this.loginState,
    required this.email,
  }) : super(key: key);

  @override
  _SignInSignUpState createState() => _SignInSignUpState();
}

class _SignInSignUpState extends State<SignInSignUp> {
  @override
  initState() {
    if (!kIsWeb) SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();

    if (widget.loginState == ApplicationLoginState.loggedIn) {
      pushReplaceToNextPage(context, Cinematic());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    if (widget.loginState == ApplicationLoginState.register) {
      return new ExploreaTitle(text: "Inscription");
    } else if (widget.loginState == ApplicationLoginState.loggedIn) {
      return new Column(
        children: [
          ExploreaTitle(text: "Connecté"),
          ExploreaText(text: widget.email ?? "?"),
        ],
      );
    } else {
      return new ExploreaTitle(text: "Connexion");
    }
  }
}