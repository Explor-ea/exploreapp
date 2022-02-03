import 'dart:developer';

import 'package:flutter/material.dart';

import '../explorea_colors.dart';

class ExploreaBtnNext extends StatefulWidget {
  ExploreaBtnNext({
    Key? key,
    this.disabled = false,
    required this.onPressed,
    // this.minimumSize = const Size(60.0, 30.0),
    this.backgroundColor = ExploreaColors.yellow,
    this.mainColor = ExploreaColors.purple,
  }) : super(key: key);

  final bool disabled;
  final Function() onPressed;
  // final Size minimumSize;
  Color backgroundColor;
  Color mainColor;

  @override
  _ExploreaBtnNextState createState() => _ExploreaBtnNextState();
}

class _ExploreaBtnNextState extends State<ExploreaBtnNext> {
  late Color backgroundColor;
  late Color mainColor;

  @override
  initState() {
    super.initState();
    this.backgroundColor = this.widget.backgroundColor;
    this.mainColor = this.widget.mainColor;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (notUsed) {
        setState(() {
          var tmpColor = this.backgroundColor;
          this.backgroundColor = this.mainColor;
          this.mainColor = tmpColor;
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
          this.backgroundColor = this.mainColor;
          this.mainColor = tmpColor;
        });
      },
      child: ClipPath(
        clipper: new CustomSquareClip(),
        child: Container(
          width: 100.0,
          height: 50.0,
          color:
              this.widget.disabled ? ExploreaColors.grey : this.backgroundColor,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0),
              child: Icon(
                Icons.arrow_forward,
                color: this.widget.mainColor,
                size: 48.0,
              )),
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
