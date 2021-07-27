import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// TODO: was here : add date picker and save date, maybe with : https://flutter.dev/docs/cookbook/persistence/key-value
class Birthdate extends StatefulWidget {
  const Birthdate({Key? key}) : super(key: key);

  @override
  _BirthdateState createState() => _BirthdateState();
}

class _BirthdateState extends State<Birthdate> {
  final GlobalKey<FormState> _formKey = GlobalKey();

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
              flex: 2,
              child: Row(
                children: [
                  Text("Quel âge avez-vous ? "),
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
                            // textValue = textValue as String;
                            // log(textValue);
                            // textValue = textValue != null ? textValue : "0";
                            return int.parse(textValue!) > 0 &&
                                    int.parse(textValue) <= 31
                                ? null
                                : "Jour incorrecte.";
                            // TODO: valid two length caractere like : https://stackoverflow.com/a/61197837
                          },
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          decoration: InputDecoration(labelText: "Mois"),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLength: 2,
                          focusNode: tf_focusNode1,
                          onSubmitted: (String textValue) => {
                            FocusScope.of(context).requestFocus(tf_focusNode2)
                          },
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          decoration: InputDecoration(labelText: "Année"),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLength: 4,
                          focusNode: tf_focusNode2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  children: [
                    Text("les points"),
                    Text("fleche"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
