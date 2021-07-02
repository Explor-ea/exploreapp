import 'dart:developer';
import 'package:flutter/material.dart';

class ConsentStepper extends StatefulWidget {
  const ConsentStepper({Key? key}) : super(key: key);

  @override
  _ConsentStepperState createState() => _ConsentStepperState();
}

class _ConsentStepperState extends State<ConsentStepper> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stepper(
        controlsBuilder: (context, {onStepCancel, onStepContinue}) => Row(
          children: [],
        ),
        steps: <Step>[
          Step(
              isActive: _index == 0,
              title: const Text("Step 1 !"),
              content: Container(
                alignment: Alignment.center,
                child: Text("contenu de qualité " + _index.toString()),
              )),
          Step(
              isActive: _index == 1,
              title: const Text("Step 2 !"),
              content: Container(
                alignment: Alignment.center,
                child: const Text("contenu encore"),
              ))
        ],
        currentStep: _index,
        onStepCancel: () {
          if (_index > 0) {
            setState(() {
              _index -= 1;
            });
          }
        },
        onStepContinue: () {
          if (_index <= 0) {
            setState(() {
              _index += 1;
            });
          }
        },
        onStepTapped: (int newIndex) {
          log("hey tapped");
          setState(() {
            _index = newIndex;
          });
        },
      ),
    );
  }
}
