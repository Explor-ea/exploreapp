import 'package:exploreapp/explorea_colors.dart';
import 'package:exploreapp/wigets/explorea-text.dart';
import 'package:exploreapp/wigets/explorea-title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Newcomer extends StatefulWidget {
  const Newcomer({Key? key}) : super(key: key);

  @override
  _NewcomerState createState() => _NewcomerState();
}

class _NewcomerState extends State<Newcomer> {
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
    return Scaffold(
      backgroundColor: ExploreaColors.yellow,
      body: Column(
        children: [
          LinearProgressIndicator(
            minHeight: 10.0,
            value: 0.25,
            backgroundColor: ExploreaColors.yellow,
            valueColor: new AlwaysStoppedAnimation(ExploreaColors.purple),
            // backgroundColor: ExploreaColors.purple,
            semanticsLabel: 'Linear progress indicator',
          ),
          SizedBox(height: 16.0),
          Container(
            color: Colors.grey,
            height: 275.0,
            width: 342,
            // padding: EdgeInsets.all(16.0),
          ),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Expanded(
              child: Column(
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
                      onPressed: () {},
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
