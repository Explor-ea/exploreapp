import 'package:flutter/material.dart';

class CustomDateAgreement extends StatefulWidget {
  const CustomDateAgreement({Key? key}) : super(key: key);

  @override
  _CustomDateAgreementState createState() => _CustomDateAgreementState();
}

class _CustomDateAgreementState extends State<CustomDateAgreement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Expanded(
                child: Text(
              "Autorisations matérielles",
              style: TextStyle(fontSize: 28.0),
            ))
          ],
        ),
      ),
    );
  }
}
