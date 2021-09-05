import 'dart:developer';

import 'package:exploreapp/pages/start_screens/newcomer/stepper/data_agreement.dart';
import 'package:exploreapp/pass_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

// TODO: was here : add date picker and save date, maybe with : https://flutter.dev/docs/cookbook/persistence/key-value
class Birthdate extends StatefulWidget {
  const Birthdate({Key? key}) : super(key: key);

  @override
  _BirthdateState createState() => _BirthdateState();
}

class _BirthdateState extends State<Birthdate> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  // final prefs = SharedPreferences.getInstance();

  void validateForm() {
    final FormState form = _formKey.currentState!;
    form.validate();
  }

  @override
  Widget build(BuildContext context) {
    FocusNode tf_focusNode1 = new FocusNode();
    FocusNode tf_focusNode2 = new FocusNode();

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
                    "Quel âge avez-vous ? ",
                    style: TextStyle(fontSize: 28.0),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Center(
                child: Form(
                  key: _formKey,
                  onChanged: validateForm,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: TextFormField(
                          decoration: InputDecoration(labelText: "Jour"),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLength: 2,
                          onFieldSubmitted: (String textValue) => {
                            FocusScope.of(context).requestFocus(tf_focusNode1)
                          },
                          validator: (textValue) {
                            if (textValue != "")
                              return int.parse(textValue!) > 0 &&
                                      int.parse(textValue) <= 31
                                  ? null
                                  : "Jour incorrecte.";
                          },
                        ),
                      ),
                      Flexible(
                        child: TextFormField(
                          decoration: InputDecoration(labelText: "Mois"),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLength: 2,
                          focusNode: tf_focusNode1,
                          onFieldSubmitted: (String textValue) => {
                            FocusScope.of(context).requestFocus(tf_focusNode2)
                          },
                          validator: (textValue) {
                            if (textValue != "")
                              return int.parse(textValue!) > 0 &&
                                      int.parse(textValue) <= 12
                                  ? null
                                  : "Mois incorrecte.";
                          },
                        ),
                      ),
                      Flexible(
                        child: TextFormField(
                          decoration: InputDecoration(labelText: "Année"),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLength: 4,
                          focusNode: tf_focusNode2,
                          validator: (textValue) {
                            if (textValue != "")
                              return int.parse(textValue!) <=
                                      new DateTime.now().year
                                  ? null
                                  : "Date incorrecte.";
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            PassPoints(
              nbPoints: 4,
              currentPoint: 1,
              // TODO: ternary with the date check
              nextPage: DataAgreement(),
            ),
          ],
        ),
      ),
    );
  }
}
