import 'package:exploreapp/main.dart';
import 'package:exploreapp/pages/profile.dart';
import 'package:exploreapp/wigets/explorea_fab.dart';
import 'package:flutter/material.dart';

class AdventureDetails extends StatelessWidget {
  final int adventureId;

  const AdventureDetails({Key? key, required this.adventureId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTapDown: (unusedDetails) {
                        goBack(context);
                      },
                      child: Row(
                        children: [Text("<<"), Text("Retour")],
                      ),
                    ),
                    ExploreaFab(
                      onPressed: () {
                        goToNextPage(context, Profil());
                      },
                      padding: const EdgeInsets.all(8.0),
                      icon: const Icon(Icons.person_outline_sharp),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
