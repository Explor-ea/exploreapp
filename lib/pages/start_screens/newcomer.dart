import 'dart:developer';
// import 'dart:math';

import 'package:exploreapp/explorea_colors.dart';
import 'package:exploreapp/main.dart';
import 'package:exploreapp/pages/start_screens/cinematic.dart';
import 'package:exploreapp/pages/start_screens/sign_in_sign_up.dart';
import 'package:exploreapp/src/permissions.dart';
import 'package:exploreapp/wigets/explorea-btn.dart';
import 'package:exploreapp/wigets/explorea-chekbox.dart';
import 'package:exploreapp/wigets/explorea-text.dart';
import 'package:exploreapp/wigets/explorea-title.dart';
import 'package:exploreapp/wigets/explorea_btn_square.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Newcomer extends StatefulWidget {
  const Newcomer({Key? key}) : super(key: key);

  @override
  _NewcomerState createState() => _NewcomerState();
}

class _NewcomerState extends State<Newcomer> {
  int step = 1; // step/5

  final List<int> days = [];
  final List<String> months = [
    "JAN",
    "FEV",
    "MAR",
    "AVR",
    "MAI",
    "JUN",
    "JUL",
    "AOU",
    "SEP",
    "OCT",
    "NOV",
    "DEC"
  ];
  final List<int> years = [];

  int? daySelected;
  String? monthSelected;
  int? yearSelected;

  SharedPreferences? prefs;
  int? prefUserBirthdate_day;
  String? prefUserBirthdate_month;
  int? prefUserBirthdate_year;
  bool? agreedData;
  bool? agreedAd;
  bool prefAgreedGeo = false;
  bool prefAgreedMicro = false;
  bool prefAgreedCamera = false;

  Future<void> initializePreference() async {
    // Prefer to use SharedPref custom class.
    this.prefs = await SharedPreferences.getInstance();

    this.prefUserBirthdate_day = prefs?.getInt("userBirthdate_day");
    this.prefUserBirthdate_month = prefs?.getString("userBirthdate_month");
    this.prefUserBirthdate_year = prefs?.getInt("userBirthdate_year");
    //
    this.agreedData = prefs?.getBool("dataAgreed") as bool;
    //
    this.agreedAd = prefs?.getBool("adAgreed") as bool;
    //
    this.prefAgreedGeo = prefs?.getBool("geoAgreed") as bool;
    this.prefAgreedMicro = prefs?.getBool("microAgreed") as bool;
    this.prefAgreedCamera = prefs?.getBool("cameraAgreed") as bool;
  }

  @override
  initState() {
    if (!kIsWeb) SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();

    this.initializePreference().whenComplete(() {
      // XXX MAYBE: make it responsive instead
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

      setState(() {});
    });
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([]);

    super.dispose();
  }

  // TODO: Add true start text.
  String text =
      "Tempor non non ullamco labore voluptate consectetur. Consectetur aliquip aliqua id sit incididunt proident deserunt eu. Magna veniam mollit quis ullamco ut cillum pariatur. Duis nulla consequat laboris proident laborum. Anim consectetur duis eu consectetur voluptate eiusmod. Esse aliquip veniam nisi anim consequat velit nulla. Est aute adipisicing eu veniam laboris enim aute irure. Aliqua sunt culpa esse fugiat sint qui qui officia et sunt laboris cillum nulla. Cupidatat est enim nostrud consequat dolor sunt qui magna pariatur. Elit cupidatat duis aute eiusmod velit pariatur aute nostrud minim elit in. Velit cupidatat minim quis incididunt in est deserunt consectetur cillum nisi ullamco velit anim. Minim dolor commodo labore dolor. Sit aliquip qui amet id occaecat irure commodo minim nisi ad sunt. Velit enim sint sint laborum dolore nisi cillum consectetur. Ad occaecat excepteur minim duis laborum ullamco et qui elit deserunt Lorem velit nisi. Ea anim laboris adipisicing minim nisi deserunt enim consequat. Quis est duis quis ea. Adipisicing enim amet ad sint consequat adipisicing magna. Deserunt dolor commodo non voluptate adipisicing magna amet magna ad minim consequat nostrud. Sunt commodo do sit occaecat. Laboris laboris dolore dolor labore velit duis pariatur laborum ullamco. Aute excepteur ut proident nisi commodo voluptate ad qui qui culpa. Id dolor officia excepteur sit dolore. ";

  @override
  Widget build(BuildContext context) {
    for (var i = 1; i <= 31; i++) {
      this.days.add(i);
    }

    int currentYear = new DateTime.now().year;
    for (var i = currentYear; i >= currentYear - 100; i--) {
      this.years.add(i);
    }

    return Container(
      decoration: const BoxDecoration(gradient: ExploreaGradients.yellow),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            this.step < 5
                ? Expanded(flex: 5, child: buildImage())
                : Container(),
            Expanded(
                flex: this.step < 5 ? 12 : (12 + 5),
                child: Column(
                  children: [
                    Container(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: buildStep(),
                      ),
                    ),
                  ],
                )),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 10.0,
                    child: LinearProgressIndicator(
                      minHeight: 10.0,

                      value: 0.20 * this.step,
                      backgroundColor: Colors.transparent,
                      valueColor:
                          new AlwaysStoppedAnimation(ExploreaColors.purple),
                      // backgroundColor: ExploreaColors.purple,
                      semanticsLabel: 'Linear progress indicator',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStep() {
    switch (this.step) {
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 2,
              child: ExploreaTitle(text: "Explor'ea"),
            ),
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Scrollbar(
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                          child: ExploreaText(text: this.text)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                // child: ElevatedButton(
                //   onPressed: () {
                //     setState(() {
                //       this.step = 2;
                //     });
                //   },
                //   // style: ButtonStyle(
                //   //     shape:
                //   //         MaterialStateProperty.all<RoundedRectangleBorder>(
                //   //             RoundedRectangleBorder(
                //   //                 borderRadius:
                //   //                     BorderRadius.circular(100)))),
                //   style: ElevatedButton.styleFrom(
                //     shape: StadiumBorder(),
                //     primary: ExploreaColors.purple,
                //     minimumSize: Size(315.0, 53),
                //   ),

                //   child: Text("C'est parti !"),
                // ),

                child: ExploreaBtnSquare(
                  onPressed: () {
                    setState(() {
                      this.step = 2;
                    });
                  },
                  text: "C'est parti !",
                  paddingHorizontal: 50.5,
                ),
              ),
            ),
          ],
        );

        break;

      //

      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 2,
              child: ExploreaTitle(text: "Quel âge avez vous ?"),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Stack(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                            initialPage: this.prefUserBirthdate_day != null
                                ? this.prefUserBirthdate_day! - 1
                                : 0,
                            height: 50.0,
                            // aspectRatio: 10.0,
                            enlargeCenterPage: true,
                            viewportFraction: 0.3,
                            enlargeStrategy: CenterPageEnlargeStrategy.scale,
                            onPageChanged: (daySelected, changeReason) {
                              daySelected = daySelected % 31 + 1;
                              log((daySelected).toString());
                              log(changeReason.toString());

                              setState(() {
                                this.daySelected = daySelected;
                              });
                            }),
                        items: this.days.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  // width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  width: 50.0,
                                  alignment: Alignment.center,
                                  child: ExploreaTitle(
                                    text: '$i',
                                    color: i == this.daySelected
                                        ? ExploreaColors.purple
                                        : (i == this.prefUserBirthdate_day &&
                                                this.daySelected == null)
                                            ? ExploreaColors.purple
                                            : Colors.grey,
                                  ));
                            },
                          );
                        }).toList(),
                      ),
                      Column(
                        children: [
                          Container(
                            height: 8.0,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.arrow_left,
                                color: ExploreaColors.purple,
                                size: 32.0,
                              ),
                              Expanded(
                                  child: Container(
                                color: Colors.green,
                              )),
                              Icon(
                                Icons.arrow_right,
                                color: ExploreaColors.purple,
                                size: 32.0,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  Stack(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                            initialPage: this
                                .months
                                .indexOf(this.prefUserBirthdate_month ?? "JAN"),
                            height: 50.0,
                            enlargeCenterPage: true,
                            viewportFraction: 0.3,
                            enlargeStrategy: CenterPageEnlargeStrategy.scale,
                            onPageChanged: (monthSelected, changeReason) {
                              this.monthSelected = this.months[monthSelected];
                              log((this.monthSelected).toString());
                              log(changeReason.toString());

                              setState(() {});
                            }),
                        items: this.months.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  // width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  // width: 70.0,
                                  alignment: Alignment.center,
                                  child: FittedBox(
                                    child: ExploreaTitle(
                                      text: '$i',
                                      color: i == this.monthSelected
                                          ? ExploreaColors.purple
                                          : (i == this.prefUserBirthdate_month &&
                                                  this.monthSelected == null)
                                              ? ExploreaColors.purple
                                              : Colors.grey,
                                    ),
                                  ));
                            },
                          );
                        }).toList(),
                      ),
                      Column(
                        children: [
                          Container(
                            height: 8.0,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.arrow_left,
                                color: ExploreaColors.purple,
                                size: 32.0,
                              ),
                              Expanded(
                                  child: Container(
                                color: Colors.green,
                              )),
                              Icon(
                                Icons.arrow_right,
                                color: ExploreaColors.purple,
                                size: 32.0,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  Stack(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                            initialPage: this
                                .years
                                .indexOf(this.prefUserBirthdate_year ?? 2021),
                            reverse: true,
                            height: 50.0,
                            enlargeCenterPage: true,
                            viewportFraction: 0.3,
                            enlargeStrategy: CenterPageEnlargeStrategy.scale,
                            onPageChanged: (yearSelected, changeReason) {
                              this.yearSelected = this.years[yearSelected];
                              log((this.yearSelected).toString());
                              log(changeReason.toString());
                              setState(() {});
                            }),
                        items: this.years.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  // width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  // width: 70.0,
                                  alignment: Alignment.center,
                                  child: FittedBox(
                                    child: ExploreaTitle(
                                      text: '$i',
                                      color: i == this.yearSelected
                                          ? ExploreaColors.purple
                                          : (i == this.prefUserBirthdate_year &&
                                                  this.yearSelected == null)
                                              ? ExploreaColors.purple
                                              : Colors.grey,
                                    ),
                                  ));
                            },
                          );
                        }).toList(),
                      ),
                      Column(
                        children: [
                          Container(
                            height: 8.0,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.arrow_left,
                                color: ExploreaColors.purple,
                                size: 32.0,
                              ),
                              Expanded(
                                  child: Container(
                                color: Colors.green,
                              )),
                              Icon(
                                Icons.arrow_right,
                                color: ExploreaColors.purple,
                                size: 32.0,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                  child: ExploreaBtnSquare(
                text: "Suivant",
                disabled: (this.daySelected == null &&
                        this.prefUserBirthdate_day == null) ||
                    (this.monthSelected == null &&
                        this.prefUserBirthdate_month == null) ||
                    (this.yearSelected == null &&
                        this.prefUserBirthdate_year == null),
                onPressed: () {
                  setState(() {
                    this.step = 3;

                    if (this.daySelected != null) {
                      this.prefUserBirthdate_day = this.daySelected;
                      prefs?.setInt(
                          "userBirthdate_day", this.prefUserBirthdate_day!);
                    }
                    if (this.monthSelected != null) {
                      this.prefUserBirthdate_month = this.monthSelected;
                      prefs?.setString(
                          "userBirthdate_month", this.prefUserBirthdate_month!);
                    }
                    if (this.yearSelected != null) {
                      this.prefUserBirthdate_year = this.yearSelected;
                      prefs?.setInt(
                          "userBirthdate_year", this.prefUserBirthdate_year!);
                    }
                  });
                },
                paddingHorizontal: 50.5,
              )),
            ),
          ],
        );
        break;

//

      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(flex: 1, child: Container()),
            Expanded(
                flex: 2,
                child: ExploreaTitle(text: "La gestion de vos données")),
            // TODO: add padding bot, for this step and the others surely
            Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Expanded(
                      child: Scrollbar(
                        isAlwaysShown: true,
                        child: SingleChildScrollView(
                            child: ExploreaText(text: this.text)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 8, 0.0, 8.0),
                      child: Row(
                        children: [
                          ExploreaCheckbox(
                            isChecked: this.agreedData ?? false,
                            onChanged: (newValue) {
                              setState(() {
                                this.agreedData = newValue;
                                if (this.agreedData != null)
                                  prefs?.setBool(
                                      'dataAgreed', this.agreedData!);
                              });
                            },
                            label: "J'accepte...",
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            Expanded(
              flex: 1,
              child: Center(
                child: ExploreaBtnSquare(
                  text: "Suivant",
                  disabled: !(this.agreedData == true),
                  paddingHorizontal: 50.5,
                  onPressed: () {
                    setState(() {
                      this.step = 4;
                    });
                  },
                ),
              ),
            ),
          ],
        );

        break;

      //

      case 4:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 2,
              child: ExploreaTitle(text: "Publicités personnalisées"),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Expanded(
                    // flex: 2,
                    child: Scrollbar(
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                          child: ExploreaText(text: this.text)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 8, 0.0, 8.0),
              child: Center(
                child: Row(
                  children: [
                    ExploreaCheckbox(
                      isChecked: this.agreedAd ?? false,
                      onChanged: (newValue) {
                        setState(() {
                          this.agreedAd = newValue;
                          if (this.agreedAd != null)
                            prefs?.setBool('adAgreed', this.agreedAd!);
                        });
                      },
                      label: "J'accepte...",
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: ExploreaBtnSquare(
                  text: "Suivant",
                  disabled: !(this.agreedAd == true),
                  paddingHorizontal: 50.5,
                  onPressed: () {
                    setState(() {
                      this.step = 5;
                    });
                  },
                ),
              ),
            ),
          ],
        );

        break;

//

      case 5:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 3,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        width: 260.0,
                        child:
                            ExploreaTitle(text: "Autorisations matérielles")),
                  ],
                ),
              ),
            ),
            SizedBox(height: 22.0),

            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ExploreaBtn(
                          onPressed: () {
                            checkAndAskPosition().then((permission) {
                              if (permission.index > 1) {
                                setState(() {
                                  this.prefAgreedGeo = true;
                                  prefs?.setBool(
                                      'geoAgreed', this.prefAgreedGeo);
                                });
                              }
                            });
                          },
                          disabled: this.prefAgreedGeo == false,
                          icon: Icons.check,
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child:
                            // btn
                            Text("Géolocalisation",
                                style: TextStyle(
                                    color: ExploreaColors.purple,
                                    fontSize: 24.0)),
                        flex: 8,
                      ),
                    ],
                  ),
                  Container(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ExploreaBtn(
                          onPressed: () {
                            setState(() {
                              this.prefAgreedMicro = !this.prefAgreedMicro;
                              prefs?.setBool(
                                  'microAgreed', this.prefAgreedMicro);
                            });
                          },
                          disabled: this.prefAgreedMicro == false,
                          icon: Icons.check,
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child: Text("Microphone",
                            style: TextStyle(
                                color: ExploreaColors.purple, fontSize: 24.0)),
                        flex: 8,
                      ),
                    ],
                  ),
                  Container(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ExploreaBtn(
                          onPressed: () {
                            setState(() {
                              this.prefAgreedCamera = !this.prefAgreedCamera;
                              prefs?.setBool(
                                  'cameraAgreed', this.prefAgreedCamera);
                            });
                          },
                          disabled: this.prefAgreedCamera == false,
                          icon: Icons.check,
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child: Text("Appareil Photo",
                            style: TextStyle(
                                color: ExploreaColors.purple, fontSize: 24.0)),
                        flex: 8,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Expanded(child: Container()),
            Center(
                child: ExploreaBtnSquare(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        Consumer<ApplicationState>(
                          builder: (context, appState, _) => SignInSignUp(
                            loginState: appState.loginState,
                          ),
                        )));
              },
              text: "C'est parti !",
              paddingHorizontal: 50.5,
              disabled: !(this.prefAgreedGeo == true &&
                  this.prefAgreedMicro == true &&
                  this.prefAgreedCamera == true),
            )),
          ],
        );

        break;

      default:
        return Container(
          color: Colors.red,
          width: 20.0,
          height: 20.0,
        );
    }
  }

  Widget buildImage() {
    switch (this.step) {
      case 1:
        return Container(
            // height: 275.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/home-scenes/home-scene-1.png"))));

      case 2:
        return Container(
            // height: 275.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/home-scenes/home-scene-2.png"))));

      case 3:
        return Container(
            // height: 275.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/home-scenes/home-scene-3.png"))));

      case 4:
        return Container(
            // height: 275.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/home-scenes/home-scene-3.png"))));

      default:
        return Container();
    }
  }
}
