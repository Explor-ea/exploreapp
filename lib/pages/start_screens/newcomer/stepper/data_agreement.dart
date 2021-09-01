import 'package:exploreapp/pages/start_screens/newcomer/stepper/custom_ad_agreement.dart';
import 'package:exploreapp/pass_points.dart';
import 'package:flutter/material.dart';

class DataAgreement extends StatefulWidget {
  bool agreed = false;

  DataAgreement({Key? key}) : super(key: key);

  @override
  _DataAgreementState createState() => _DataAgreementState();
}

class _DataAgreementState extends State<DataAgreement> {
  final textAgreement =
      "Velit quis eu ut voluptate minim in. Veniam Lorem consequat deserunt et excepteur mollit exercitation occaecat non laborum. Ullamco do incididunt do ipsum commodo nostrud et magna dolor nostrud culpa cupidatat magna. Velit esse anim ex minim quis commodo qui. Occaecat velit duis ullamco enim sint cupidatat consectetur commodo officia cupidatat nisi officia veniam. Culpa non laboris adipisicing nulla Lorem est. Laborum consequat nisi sit consequat nisi anim dolor in eiusmod duis est. Esse est consequat voluptate sint incididunt aliqua qui do consectetur. Excepteur esse quis fugiat reprehenderit Lorem consequat minim id esse cupidatat. Labore dolore anim dolore aliqua. Veniam cillum do consectetur do. Ex duis labore duis cillum ullamco velit Lorem occaecat ipsum. Sunt laborum magna consectetur proident ea sit qui mollit commodo dolor nostrud esse. Dolore mollit Lorem adipisicing culpa aliqua cupidatat in quis ex. Ex id adipisicing nulla irure occaecat nulla fugiat. Consequat reprehenderit ullamco excepteur incididunt. Sunt cupidatat quis in quis mollit esse pariatur nulla proident duis officia aute laboris. Voluptate ea amet duis sint nostrud incididunt velit nostrud. Labore nostrud irure nisi laboris commodo commodo cupidatat consectetur reprehenderit exercitation est. Irure nostrud ullamco ex exercitation. Enim ipsum ut tempor Lorem eu aliqua irure pariatur nulla aute ipsum in id id. Occaecat ex reprehenderit amet laborum et eiusmod. Tempor nisi aute id laborum aute ea exercitation ea ea incididunt. Do ea sit fugiat mollit esse. Labore laborum esse duis dolor excepteur. Et anim ullamco amet officia. Duis commodo in esse reprehenderit labore excepteur irure incididunt proident. Sunt nulla consequat irure laborum cupidatat ad amet ut do. Pariatur consectetur laboris minim laborum incididunt sint ad nulla ea reprehenderit aute ullamco do deserunt. Velit sunt amet ut minim ex ipsum. Consectetur reprehenderit ex in aute mollit amet. Eu consectetur minim ipsum commodo pariatur dolore aliqua exercitation magna excepteur aliquip nulla esse ipsum. Eiusmod cillum id ipsum ex excepteur ullamco duis amet irure.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Text(
                      "La gestion de vos données",
                      style: TextStyle(fontSize: 28.0),
                    ),
                  ],
                )),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  SizedBox(
                    height: 16.0,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(textAgreement),
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: widget.agreed,
                        onChanged: (newValue) {
                          widget.agreed = newValue as bool;
                          setState(() {});
                        },
                      ),
                      Text("J'accepte...")
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 16.0),
            PassPoints(
                nbPoints: 4,
                currentPoint: 2,
                nextPage: widget.agreed ? CustomDateAgreement() : null),
          ],
        ),
      ),
    );
  }
}
