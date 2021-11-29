import 'package:exploreapp/main.dart';
import 'package:exploreapp/pages/adventures/adventure_1_gulls.dart';
import 'package:exploreapp/src/navigation.dart';
import 'package:flutter/material.dart';

launchAdventure(int adventureId, BuildContext context) {
  // Veriffy that the user is connected
  // then verify that he can launch this adventure by requested it's `allowedScenario`
  // if this is allowed, Navigator push the corresponding Adventure Widget page.

  Widget? nextPageWidget;
  switch (adventureId) {
    case 1:
      nextPageWidget = Adventure1Gulls();
      break;

    default:
      goToNextPage(
          context, ErrorWidget(Exception("Impossible de lancer le scénario.")));
      return false;
  }

  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => nextPageWidget!),
      (route) => false);
  // return true;
}
