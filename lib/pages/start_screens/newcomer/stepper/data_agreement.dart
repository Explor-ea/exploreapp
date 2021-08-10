import 'package:flutter/material.dart';

class DataAgreement extends StatelessWidget {
  const DataAgreement({Key? key}) : super(key: key);

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
                  Text("La gestion de vos données"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
