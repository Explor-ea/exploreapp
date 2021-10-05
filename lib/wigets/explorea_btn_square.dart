import 'package:flutter/material.dart';

import '../explorea_colors.dart';

class ExploreaBtnSquare extends StatelessWidget {
  const ExploreaBtnSquare(
      {Key? key,
      this.disabled = false,
      required this.text,
      required this.onPressed,
      this.minimumSize = const Size(60.0, 60.0),
      this.width: 20.0})
      : super(key: key);

  final bool disabled;
  final String text; // Icon(Icons.arrow_right_alt, size: 32.0)
  final Function() onPressed;
  final Size minimumSize;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: this.onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: this.width,
        ),
        shape:
            BeveledRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        primary: this.disabled == true ? Colors.grey : ExploreaColors.purple,
        minimumSize: this.minimumSize,
      ),
      child: Text(
        this.text,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}
