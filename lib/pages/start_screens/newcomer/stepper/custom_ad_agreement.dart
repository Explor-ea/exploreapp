import 'package:exploreapp/pages/start_screens/newcomer/stepper/permissions_agreement.dart';
import 'package:exploreapp/pass_points.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDateAgreement extends StatefulWidget {
  CustomDateAgreement({Key? key}) : super(key: key);

  @override
  _CustomDateAgreementState createState() => _CustomDateAgreementState();
}

class _CustomDateAgreementState extends State<CustomDateAgreement> {
  final textAgreement =
      "Reprehenderit voluptate laboris laboris aliqua non elit pariatur proident officia. Adipisicing exercitation ea sit id reprehenderit. Fugiat voluptate amet ea aute mollit ipsum aliquip est et esse occaecat laborum laborum. Id ad et irure cillum excepteur nulla. Sunt exercitation pariatur adipisicing in deserunt Lorem quis cillum dolor reprehenderit aliquip.";

  bool agreed = false;

  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    this.initializePreference().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> initializePreference() async {
    this.prefs = await SharedPreferences.getInstance();
    // FIXME: Exception _CastError, fix with : https://stackoverflow.com/a/57069455 maybe
    this.agreed = prefs?.getBool("adAgreed") as bool;
  }

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
                      "Publicités personnalisées",
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
                  )),
                  Row(
                    children: [
                      Checkbox(
                          value: this.agreed,
                          onChanged: (newValue) {
                            setState(() {
                              this.agreed = newValue as bool;
                              prefs?.setBool('adAgreed', this.agreed);
                            });
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
              nextPage: this.agreed ? PermissionsAgreement() : null,
            )
          ],
        ),
      ),
    );
  }
}
