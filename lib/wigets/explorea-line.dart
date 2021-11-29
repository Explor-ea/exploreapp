import 'package:exploreapp/explorea_colors.dart';
import 'package:flutter/material.dart';

class ExploreaLine extends StatelessWidget {
  const ExploreaLine({
    Key? key,
    this.color = ExploreaColors.purple,
    this.width = 50.0,
    this.padding,
  }) : super(key: key);

  final Color color;
  final double width;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: this.padding ?? EdgeInsets.all(0.0),
      child: Container(
        width: this.width,
        child: Divider(
          thickness: 2.0,
          color: this.color,
        ),
      ),
    );
  }
}
