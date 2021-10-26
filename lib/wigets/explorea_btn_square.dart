import 'package:flutter/material.dart';

import '../explorea_colors.dart';

class ExploreaBtnSquare extends StatelessWidget {
  const ExploreaBtnSquare({
    Key? key,
    this.disabled = false,
    required this.text,
    required this.onPressed,
    this.minimumSize = const Size(60.0, 30.0),
    this.paddingVertical = 16.0,
    this.paddingHorizontal = 24.0,
  }) : super(key: key);

  final bool disabled;
  final String text; // Icon(Icons.arrow_right_alt, size: 32.0)
  final Function() onPressed;
  final Size minimumSize;
  final double paddingVertical;
  final double paddingHorizontal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: this.onPressed,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              vertical: this.paddingVertical,
              horizontal: this.paddingHorizontal,
            ),
            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            primary:
                this.disabled ? ExploreaColors.grey : ExploreaColors.purple,
            minimumSize: this.minimumSize,
          ),
          child: Text(
            this.text,
            style: TextStyle(
                fontSize: 16.0,
                color: this.disabled ? ExploreaColors.darkGrey : null),
          ),
        ),
      ],
    );
  }
}
