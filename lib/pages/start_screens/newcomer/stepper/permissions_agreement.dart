import 'package:flutter/material.dart';

class PermissionsAgreement extends StatefulWidget {
  bool agreed_geo = false;
  bool agreed_microphone = false;
  bool agreed_camera = false;

  PermissionsAgreement({Key? key}) : super(key: key);

  @override
  _PermissionsAgreementState createState() => _PermissionsAgreementState();
}

class _PermissionsAgreementState extends State<PermissionsAgreement> {
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
                    "Autorisations matérielles",
                    style: TextStyle(fontSize: 28.0),
                  ),
                ],
              )),
          Expanded(
              flex: 5,
              child: Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: widget.agreed_geo,
                        onChanged: (newValue) {},
                      ),
                      Text("Géolocalisation")
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: widget.agreed_microphone,
                        onChanged: (newValue) {},
                      ),
                      Text("Micro")
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: widget.agreed_camera,
                        onChanged: (newValue) {},
                      ),
                      Text("Appareil photo")
                    ],
                  ),
                ],
              ))
        ],
      ),
    ));
  }
}
