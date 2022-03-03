import 'dart:async';
import 'dart:developer';

import 'package:exploreapp/explorea_colors.dart';
import 'package:flutter/material.dart';

class ExploreaTimer extends StatefulWidget {
  const ExploreaTimer({
    Key? key,
    required this.currentTime,
    this.color = Colors.white,
    this.bgColor = ExploreaColors.purple,
    this.borderColor,
    this.width = 130,
  }) : super(key: key);

  @override
  _ExploreaTimerState createState() => _ExploreaTimerState();

  final int currentTime;
  final Color color;
  final Color bgColor;
  final Color? borderColor;
  final double width;
}

class _ExploreaTimerState extends State<ExploreaTimer> {
  @override
  void initState() {
    super.initState();
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
      width: this.widget.width,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: this.widget.bgColor,
        border: Border.all(
          color: this.widget.borderColor ?? Colors.black.withOpacity(0.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.access_time, color: this.widget.color),
            Container(width: 16),
            Container(
              child: Text(
                displayTimeAsTimer(this.widget.currentTime),
                style: TextStyle(fontSize: 24.0, color: this.widget.color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
