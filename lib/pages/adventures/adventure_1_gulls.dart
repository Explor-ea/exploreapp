import 'package:exploreapp/wigets/explorea_timer.dart';
import 'package:flutter/material.dart';

class Adventure1Gulls extends StatefulWidget {
  const Adventure1Gulls({Key? key}) : super(key: key);

  @override
  _Adventure1GullsState createState() => _Adventure1GullsState();
}

class _Adventure1GullsState extends State<Adventure1Gulls> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 30.0,
          ),
          ExploreaTimer(
            totalTime: Duration(seconds: 68),
          ),
        ],
      ),
    );
  }
}
