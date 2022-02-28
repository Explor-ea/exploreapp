import 'package:exploreapp/pages/start_screens/cinematic.dart';
import 'package:exploreapp/pass_points.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PermissionsAgreement extends StatefulWidget {
  PermissionsAgreement({Key? key}) : super(key: key);

  @override
  _PermissionsAgreementState createState() => _PermissionsAgreementState();
}

class _PermissionsAgreementState extends State<PermissionsAgreement> {
  bool agreed_geo = false;
  bool agreed_microphone = false;
  bool agreed_camera = false;

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
    this.agreed_geo = prefs?.getBool("geoAgreed") as bool;
    this.agreed_microphone = prefs?.getBool("microphoneAgreed") as bool;
    this.agreed_camera = prefs?.getBool("cameraAgreed") as bool;
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
                      value: this.agreed_geo,
                      onChanged: (newValue) {
                        setState(() {
                          this.agreed_geo = newValue!;
                          prefs?.setBool('geoAgreed', newValue);
                        });
                      },
                    ),
                    Text("Géolocalisation")
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: this.agreed_microphone,
                      onChanged: (newValue) {
                        setState(() {
                          this.agreed_microphone = newValue!;
                          prefs?.setBool('microphoneAgreed', newValue);
                        });
                      },
                    ),
                    Text("Micro")
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: this.agreed_camera,
                      onChanged: (newValue) {
                        setState(() {
                          this.agreed_camera = newValue!;
                          prefs?.setBool('cameraAgreed', newValue);
                        });
                      },
                    ),
                    Text("Appareil photo")
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          PassPoints(
              nbPoints: 4,
              currentPoint: 4,
              nextPage: this.agreed_geo &&
                      this.agreed_microphone &&
                      this.agreed_camera
                  ? Cinematic()
                  : null),
        ],
      ),
    ));
  }
}
