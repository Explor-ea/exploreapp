import 'dart:developer';

import 'package:flutter/material.dart';

import '../explorea_colors.dart';

class ExploreaBtnSquare extends StatefulWidget {
  ExploreaBtnSquare({
    Key? key,
    this.disabled = false,
    required this.text,
    required this.onPressed,
    // this.minimumSize = const Size(60.0, 30.0),
    this.paddingVertical = 16.0,
    this.paddingHorizontal = 24.0,
    this.backgroundColor = ExploreaColors.purple,
    this.textColor = Colors.white,
  }) : super(key: key);

  final bool disabled;
  final String text; // Icon(Icons.arrow_right_alt, size: 32.0)
  final Function() onPressed;
  // final Size minimumSize;
  double paddingVertical;
  double paddingHorizontal;
  Color backgroundColor;
  Color textColor;

  @override
  _ExploreaBtnSquareState createState() => _ExploreaBtnSquareState();
}

class _ExploreaBtnSquareState extends State<ExploreaBtnSquare> {
  late Color backgroundColor;
  late Color textColor;

  @override
  initState() {
    super.initState();
    this.backgroundColor = this.widget.backgroundColor;
    this.textColor = this.widget.textColor;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (notUsed) {
        setState(() {
          var tmpColor = this.backgroundColor;
          this.backgroundColor = this.textColor;
          this.textColor = tmpColor;
        });

        // Call the given onPressed Function
        if (!this.widget.disabled) this.widget.onPressed();
      },
      onTapUp: (notUsed) {
        // Strangely, this helps to trigger the onPanCancel()
      },
      onPanCancel: () {
        setState(() {
          var tmpColor = this.backgroundColor;
          this.backgroundColor = this.textColor;
          this.textColor = tmpColor;
        });
      },
      child: ClipPath(
        clipper: new CustomSquareClip(),
        child: Container(
          color:
              this.widget.disabled ? ExploreaColors.grey : this.backgroundColor,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: this.widget.paddingHorizontal,
                vertical: this.widget.paddingVertical),
            child: Text(
              this.widget.text,
              style: TextStyle(
                  fontSize: 16.0,
                  color: this.widget.disabled
                      ? ExploreaColors.darkGrey
                      : this.textColor),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSquareClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final edgeCut = 25.0;

    final path = Path();
    path.lineTo(size.width - edgeCut, 0);
    path.lineTo(size.width, 0 + edgeCut);
    path.lineTo(size.width, size.height);
    path.lineTo(0 + edgeCut, size.height);
    path.lineTo(0, size.height - edgeCut);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomSquareClip oldClipper) => false;
}
