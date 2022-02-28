import 'package:flutter/material.dart';

pushReplaceToNextPage(BuildContext context, Widget nextPage) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => nextPage));
}

goToNextPage(BuildContext context, Widget nextPage) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => nextPage));
}

goBack(BuildContext context) {
  Navigator.pop(context);
}

/// This can to fulfil navigation needs when the context itsn't reachable.
///
/// @see https://stackoverflow.com/a/63325745/13880103
class NavigationService {
  GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  static NavigationService navServiceInstance = NavigationService();

  NavigationService();

  Future<dynamic> navigateTo(Widget nextPage) {
    return navKey.currentState!
        .push(MaterialPageRoute(builder: (context) => nextPage));
  }

  Future<dynamic> navigateToReplacement(String _rn) {
    return navKey.currentState!.pushReplacementNamed(_rn);
  }

  // Future<dynamic> navigateTo(String _rn) {
  //   return navKey.currentState!.pushNamed(_rn);
  // }

  Future<dynamic> navigateToRoute(MaterialPageRoute _rn) {
    return navKey.currentState!.push(_rn);
  }

  goback() {
    return navKey.currentState!.pop();
  }
}
