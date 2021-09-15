import 'dart:developer';
// import 'dart:math';

import 'package:exploreapp/explorea_colors.dart';
import 'package:exploreapp/wigets/explorea-text.dart';
import 'package:exploreapp/wigets/explorea-title.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:carousel_slider/carousel_slider.dart';

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

  @override
  initState() {
    super.initState();
    // XXX MAYBE: make it responsive instead
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([]);

    super.dispose();
  }

  String text =
      "Tempor non non ullamco labore voluptate consectetur. Consectetur aliquip aliqua id sit incididunt proident deserunt eu. Magna veniam mollit quis ullamco ut cillum pariatur. Duis nulla consequat laboris proident laborum. Anim consectetur duis eu consectetur voluptate eiusmod. Esse aliquip veniam nisi anim consequat velit nulla. Est aute adipisicing eu veniam laboris enim aute irure. Aliqua sunt culpa esse fugiat sint qui qui officia et sunt laboris cillum nulla. Cupidatat est enim nostrud consequat dolor sunt qui magna pariatur. Elit cupidatat duis aute eiusmod velit pariatur aute nostrud minim elit in. Velit cupidatat minim quis incididunt in est deserunt consectetur cillum nisi ullamco velit anim. Minim dolor commodo labore dolor. Sit aliquip qui amet id occaecat irure commodo minim nisi ad sunt. Velit enim sint sint laborum dolore nisi cillum consectetur. Ad occaecat excepteur minim duis laborum ullamco et qui elit deserunt Lorem velit nisi. Ea anim laboris adipisicing minim nisi deserunt enim consequat. Quis est duis quis ea. Adipisicing enim amet ad sint consequat adipisicing magna. Deserunt dolor commodo non voluptate adipisicing magna amet magna ad minim consequat nostrud. Sunt commodo do sit occaecat. Laboris laboris dolore dolor labore velit duis pariatur laborum ullamco. Aute excepteur ut proident nisi commodo voluptate ad qui qui culpa. Id dolor officia excepteur sit dolore. ";

  @override
  Widget build(BuildContext context) {
    for (var i = 1; i < 31; i++) {
      this.days.add(i);
    }

    int currentYear = new DateTime.now().year;
    for (var i = currentYear - 100; i < currentYear; i++) {
      this.years.add(i);
    }

    return Scaffold(
      backgroundColor: ExploreaColors.yellow,
      body: Column(
        children: [
          LinearProgressIndicator(
            minHeight: 10.0,
            value: 0.20 * this.step,
            backgroundColor: ExploreaColors.yellow,
            valueColor: new AlwaysStoppedAnimation(ExploreaColors.purple),
            // backgroundColor: ExploreaColors.purple,
            semanticsLabel: 'Linear progress indicator',
          ),
          SizedBox(height: 16.0),
          Expanded(
              flex: 3,
              child: ConstrainedBox(
                constraints: new BoxConstraints(
                  maxHeight: 275.0,
                  // maxWidth: 342.0,
                  maxWidth: 275.0 / 9 * 16,
                ),
                child: Container(
                  color: Colors.grey,
                  // height: 275.0,
                  width: 342,

                  // padding: EdgeInsets.all(16.0),
                ),
              )),
          Expanded(
              flex: 8,
              child: Column(
                children: [
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Expanded(
                      child: buildStep(),
                    ),
                  ),
                ],
              )),
        ],
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
            ExploreaTitle(text: "Explor'ea"),
            SizedBox(height: 22.0),
            Container(
              width: 268,
              height: 189,
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
            Container(
              height: 58,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    this.step = 2;
                  });
                },
                // style: ButtonStyle(
                //     shape:
                //         MaterialStateProperty.all<RoundedRectangleBorder>(
                //             RoundedRectangleBorder(
                //                 borderRadius:
                //                     BorderRadius.circular(100)))),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  primary: ExploreaColors.purple,
                  minimumSize: Size(315.0, 53),
                ),

                child: Text("C'est parti !"),
              ),
            ),
            Container(
              height: 41,
            )
          ],
        );

        break;
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ExploreaTitle(text: "Quel âge avez vous ?"),
            SizedBox(height: 22.0),
            Container(
              height: 46,
            ),
            CarouselSlider(
              options: CarouselOptions(
                  // aspectRatio: 10.0,
                  enlargeCenterPage: true,
                  viewportFraction: 0.3,
                  // height: 30.0,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (daySelected, changeReason) {
                    log((daySelected % 30 + 1).toString());
                    log(changeReason.toString());
                  }),
              items: days.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        // width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        width: 50.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: Colors.red),
                        child: ExploreaTitle(
                          text: '$i',
                        ));
                  },
                );
              }).toList(),
            ),
            Container(
              height: 30,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    this.step = 3;
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  primary: ExploreaColors.purple,
                  minimumSize: Size(315.0, 53),
                ),
                child: Icon(Icons.arrow_right_alt),
              ),
            ),
            Container(
              height: 41,
            )
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
}
