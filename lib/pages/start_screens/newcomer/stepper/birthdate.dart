import 'package:flutter/material.dart';

// TODO: was here : add date picker and save date, maybe with : https://flutter.dev/docs/cookbook/persistence/key-value
class Birthdate extends StatelessWidget {
  const Birthdate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: Text("..."),
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
