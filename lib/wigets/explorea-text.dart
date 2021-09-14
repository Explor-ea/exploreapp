import 'package:exploreapp/explorea_colors.dart';
import 'package:flutter/material.dart';

class ExploreaText extends StatelessWidget {
  const ExploreaText({
    Key? key,
    required this.text,
    this.color = ExploreaColors.purple,
  }) : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      style: TextStyle(fontSize: 16.0, color: this.color),
    );
  }
}
