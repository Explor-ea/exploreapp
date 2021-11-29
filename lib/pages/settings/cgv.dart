import 'package:exploreapp/wigets/explorea-line.dart';
import 'package:exploreapp/wigets/explorea-title-secondary.dart';
import 'package:exploreapp/wigets/explorea_fab.dart';
import 'package:flutter/material.dart';

import '../../explorea_colors.dart';

class Cgv extends StatelessWidget {
  const Cgv({Key? key}) : super(key: key);

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
            Container(
              height: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExploreaTitleSecondary(text: "Conditions"),
                Row(
                  children: [
                    ExploreaLine(
                      width: 40.0,
                      color: ExploreaColors.yellow,
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                    ),
                    ExploreaTitleSecondary(text: "Générales")
                  ],
                ),
                ExploreaTitleSecondary(text: "de Vente")
              ],
            ),
            Container(
              height: 50,
            ),
            Expanded(
                child: SingleChildScrollView(
              // TODO: integrate real CFV text
              child: Text(
                """
              Fugiat labore anim duis Lorem nulla nulla nostrud irure enim. Elit occaecat culpa dolore fugiat cillum non non cupidatat sint deserunt voluptate pariatur eiusmod fugiat. Ad eiusmod velit anim dolor consequat ad do nisi quis qui dolore. 
              Cillum commodo ad elit duis excepteur enim culpa proident ullamco excepteur laborum.
              Duis dolor qui qui deserunt dolore anim incididunt anim culpa. Consequat adipisicing consectetur est elit nisi. Deserunt labore aute ullamco duis.
              Anim dolore ut aliqua eiusmod fugiat tempor ullamco magna incididunt excepteur elit. Pariatur aliqua consectetur ex labore deserunt deserunt aliquip Lorem ad excepteur ullamco fugiat. Do officia esse ullamco incididunt ex et ut duis enim eiusmod duis consectetur veniam.
              Quis velit eu ea culpa. Ea eiusmod ex ullamco tempor deserunt ex nostrud ipsum ex amet aute. Ut ipsum Lorem reprehenderit nostrud ex exercitation.
              Id duis exercitation non minim. Voluptate proident tempor labore Lorem ut ex sunt mollit labore. Lorem officia anim exercitation esse. Consectetur tempor eiusmod duis laboris qui duis laborum aliqua.
              Id duis exercitation non minim. Voluptate proident tempor labore Lorem ut ex sunt mollit labore. Lorem officia anim exercitation esse. Consectetur tempor eiusmod duis laboris qui duis laborum aliqua.
              """,
                style: TextStyle(color: ExploreaColors.purpleDark),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
