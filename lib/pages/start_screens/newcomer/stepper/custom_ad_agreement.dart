import 'package:exploreapp/pages/start_screens/newcomer/stepper/permissions_agreement.dart';
import 'package:exploreapp/pass_points.dart';
import 'package:flutter/material.dart';

class CustomDateAgreement extends StatefulWidget {
  bool agreed = false;

  CustomDateAgreement({Key? key}) : super(key: key);

  @override
  _CustomDateAgreementState createState() => _CustomDateAgreementState();
}

class _CustomDateAgreementState extends State<CustomDateAgreement> {
  final textAgreement =
      "Reprehenderit voluptate laboris laboris aliqua non elit pariatur proident officia. Adipisicing exercitation ea sit id reprehenderit. Fugiat voluptate amet ea aute mollit ipsum aliquip est et esse occaecat laborum laborum. Id ad et irure cillum excepteur nulla. Sunt exercitation pariatur adipisicing in deserunt Lorem quis cillum dolor reprehenderit aliquip.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Text(
                  "Publicités personnalisées",
                  style: TextStyle(fontSize: 28.0),
                )),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  SizedBox(
                    height: 16.0,
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Text(textAgreement),
                  )),
                  Row(
                    children: [
                      Checkbox(
                          value: widget.agreed,
                          onChanged: (newValue) {
                            widget.agreed = newValue as bool;
                            setState(() {});
                          }),
                      Text("J'accepte...")
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            PassPoints(
              nbPoints: 4,
              currentPoint: 3,
              nextPage: widget.agreed ? PermissionsAgreement() : null,
            )
          ],
        ),
      ),
    );
  }
}
