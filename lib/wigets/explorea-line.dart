import 'package:exploreapp/explorea_colors.dart';
import 'package:flutter/material.dart';

class ExploreaLine extends StatelessWidget {
  const ExploreaLine(
      {Key? key, this.color = ExploreaColors.purple, this.width = 50.0})
      : super(key: key);

  final Color color;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      child: Divider(
        thickness: 2.0,
        color: this.color,
      ),
    );
  }
}
