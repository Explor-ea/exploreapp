import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploreapp/explorea_colors.dart';
import 'package:exploreapp/pages/adventures/adventure_1_gulls.dart';
import 'package:exploreapp/pages/start_screens/newcomer.dart';
import 'package:exploreapp/pages/start_screens/sign_in_sign_up.dart';
import 'package:exploreapp/src/SharedPref.dart';
import 'package:exploreapp/src/dateConverter.dart';
import 'package:exploreapp/src/navigation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import "package:firebase_core/firebase_core.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:provider/provider.dart";

import 'package:exploreapp/src/authentification.dart';
import 'package:exploreapp/pages/start_screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // @see https://stackoverflow.com/a/60769935
  if (!kIsWeb) SystemChrome.setEnabledSystemUIOverlays([]);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await SharedPref.init();
  int? bdDay = SharedPref.theSharedPreferences!.getInt("userBirthdate_day");
  String? bdMonth =
      SharedPref.theSharedPreferences!.getString("userBirthdate_month");
  int? bdYear = SharedPref.theSharedPreferences!.getInt("userBirthdate_year");
  //
  bool? agreedData = SharedPref.theSharedPreferences!.getBool("dataAgreed");
  //
  bool? agreedAd = SharedPref.theSharedPreferences!.getBool("adAgreed");
  //
  bool? agreedGeo = SharedPref.theSharedPreferences!.getBool("geoAgreed");
  bool? agreedMicro = SharedPref.theSharedPreferences!.getBool("microAgreed");
  bool? agreedCamera = SharedPref.theSharedPreferences!.getBool("cameraAgreed");

  bool passNewcomerScreens = (bdDay != null) &&
      (bdMonth != null) &&
      (bdYear != null) &&
      (agreedData == true) &&
      (agreedAd == true) &&
      (agreedGeo == true) &&
      (agreedMicro == true) &&
      (agreedCamera == true);

  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: (context, _) => passNewcomerScreens
        ? MyApp(firstWidget:
            Consumer<ApplicationState>(builder: (context, appState, _) {
            return SignInSignUp(
              loginState: appState.loginState,
            );
          }))
        : MyApp(),
  ));

  // runApp(ChangeNotifierProvider(
  //   create: (context) => ApplicationState(),
  //   builder: (context, _) => MyApp(),
  // ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final Widget firstWidget;

  const MyApp({this.firstWidget = const Newcomer()});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.navServiceInstance.navKey,
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: MaterialColor(0xffF3B817, <int, Color>{
            50: Color(0xffF3B817),
            100: Color(0xffF3B817),
            200: Color(0xffF3B817),
            300: Color(0xffF3B817),
            400: Color(0xffF3B817),
            500: Color(0xffF3B817),
            600: Color(0xffF3B817),
            700: Color(0xffF3B817),
            800: Color(0xffF3B817),
            900: Color(0xffF3B817),
          }),
          // primaryColor: ExploreaColors.yellow,
          fontFamily: "ABCProphet"),
      // home: SplashScreen(),
      home: this.firstWidget,
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Uses the provider package to make a centralized application state object available throughout the application's tree of Flutter widgets
///
/// Among other things (doubtlessly), this class
/// * init Firebase
/// * handles the authorization flow
/// *
///
class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }
  Future<void> init() async {
    await Firebase.initializeApp();

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
        _email = user.email;
      } else {
        _loginState = ApplicationLoginState.loggedOut;
      }
      notifyListeners();
    });
  }

  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _loginState;

  String? _email;
  String? get email => _email;

  void startLoginFlow() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  void verifyEmail(
    String email,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      var methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')) {
        _loginState = ApplicationLoginState.password;
      } else {
        _loginState = ApplicationLoginState.register;
      }
      _email = email;
      notifyListeners();
    } on FirebaseAuthException catch (exc) {
      errorCallback(exc);
    }
  }

  void signInWithEmailAndPassword(
    String email,
    String password,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void cancelRegistration() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  Future<bool> registerAccount(String email, String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    bool ret = false;

    try {
      var year = SharedPref.theSharedPreferences!.getInt("userBirthdate_year")!;
      var month = getIntFromMonth(
          SharedPref.theSharedPreferences!.getString("userBirthdate_month")!);
      var day = SharedPref.theSharedPreferences!.getInt("userBirthdate_day")!;

      var userCredentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredentials.user != null)
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredentials.user!.uid)
            .set({
          "birthdate": DateTime(
            year,
            month,
            day,
          ),
          "playedScenario": [],
          "allowedScenario": [1],
          "success": []
        });

      ret = true;
    } on FirebaseAuthException catch (err) {
      errorCallback(err);
    } catch (err) {
      NavigationService.navServiceInstance.navigateTo(AlertDialog(
        title: const Text("Erreur"),
      ));
    }

    return ret;
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String? title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title!),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

// pushReplaceToNextPage(BuildContext context, Widget nextPage) {
//   Navigator.of(context)
//       .pushReplacement(MaterialPageRoute(builder: (context) => nextPage));
// }

// goToNextPage(BuildContext context, Widget nextPage) {
//   Navigator.push(context, MaterialPageRoute(builder: (context) => nextPage));
// }

// goBack(BuildContext context) {
//   Navigator.pop(context);
// }
