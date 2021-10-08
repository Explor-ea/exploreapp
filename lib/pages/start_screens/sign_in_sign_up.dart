import 'package:exploreapp/explorea_colors.dart';
import 'package:exploreapp/main.dart';
import 'package:exploreapp/wigets/explorea-title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:exploreapp/src/authentification.dart';

class SignInSignUp extends StatefulWidget {
  const SignInSignUp({Key? key}) : super(key: key);

  @override
  _SignInSignUpState createState() => _SignInSignUpState();
}

class _SignInSignUpState extends State<SignInSignUp> {
  @override
  initState() {
    if (!kIsWeb) SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ExploreaColors.yellow,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Container(
                      width: 37.0,
                      height: 37.0,
                      color: ExploreaColors.purple,
                    ),
                  ),
                  ExploreaTitle(text: "Connexion"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Expanded(
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
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 80.0,
            )
          ],
        ));

    /*
  TODO: Rediriger un moment vers : 
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => Cinematic()));

  */
  }
}
