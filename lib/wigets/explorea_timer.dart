import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

class ExploreaTimer extends StatefulWidget {
  const ExploreaTimer({
    Key? key,
    required this.totalTime,
  }) : super(key: key);

  @override
  _ExploreaTimerState createState() => _ExploreaTimerState();

  final Duration totalTime;
}

class _ExploreaTimerState extends State<ExploreaTimer> {
  late int _counter;
  late Timer _timer;

  @override
  void initState() {
    this._counter = this.widget.totalTime.inSeconds;

    this._timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0)
          _counter--;
        else
          this._timer.cancel();
      });
    });

    // super.initState();
  }

  String displayTimeAsTimer(nbSecondes) {
    String retMin = "";
    String retSec = "";

    int displayedMin = (nbSecondes ~/ 60);
    if (displayedMin < 10)
      retMin = "0" + displayedMin.toString();
    else
      retMin = displayedMin.toString();
    //
    int displayedSec = (nbSecondes % 60);
    if (displayedSec < 10)
      retSec = "0" + displayedSec.toString();
    else
      retSec = displayedSec.toString();

    return retMin + ":" + retSec;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        displayTimeAsTimer(this._counter),
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}
