import 'dart:developer';

import 'package:exploreapp/wigets/explorea-line.dart';
import 'package:exploreapp/wigets/explorea-note-frame.dart';
import 'package:exploreapp/wigets/explorea-title-secondary.dart';
import 'package:exploreapp/wigets/explorea_fab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../explorea_colors.dart';

class PersonalInfos extends StatefulWidget {
  const PersonalInfos({Key? key}) : super(key: key);

  @override
  State<PersonalInfos> createState() => _PersonalInfosState();
}

// TODO: maybe add the possibility to verify user's email.
class _PersonalInfosState extends State<PersonalInfos> {
  final TextEditingController tecEmail = new TextEditingController();
  final TextEditingController tecPassword = new TextEditingController();
  User? currentUser;

  @override
  void initState() {
    this.currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      tecEmail.text = currentUser!.email ?? "";
    }

    tecPassword.text = "******";

    super.initState();
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
            Container(height: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExploreaTitleSecondary(text: "Vos"),
                Row(
                  children: [
                    ExploreaLine(
                      width: 40.0,
                      color: ExploreaColors.yellow,
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                    ),
                    ExploreaTitleSecondary(text: "Informations")
                  ],
                ),
              ],
            ),
            Container(height: 50),
            buildRowWithTF(Icons.mail_outline_outlined, tecEmail, "E-mail"),
            Container(height: 50),
            buildRowWithTF(Icons.lock_outline, tecPassword, "Mot de passe"),
          ],
        ),
      ),
    );
  }

  Widget buildRowWithTF(
      IconData anIcon, TextEditingController aTEC, String? aHintText) {
    return Row(
      children: [
        ExploreaNoteFrame(
          width: 60,
          height: 60,
          padding: EdgeInsets.zero,
          child: Center(
            child: Icon(
              anIcon,
              color: Colors.white,
            ),
          ),
        ),
        Container(width: 30),
        Flexible(
          child: TextFormField(
            cursorColor: ExploreaColors.purple,
            keyboardType: TextInputType.emailAddress,
            readOnly: true,
            controller: aTEC,
            style: const TextStyle(
              color: ExploreaColors.purple,
              decorationColor: ExploreaColors.purple,
            ),
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                color: ExploreaColors.purple,
              )),
              focusColor: ExploreaColors.purple,
              fillColor: ExploreaColors.purple,
              hintText: aHintText,
            ),
          ),
        )
      ],
    );
  }
}
