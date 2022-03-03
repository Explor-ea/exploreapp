import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../explorea_colors.dart';

class ExploreaBtnNext extends StatefulWidget {
  ExploreaBtnNext({
    Key? key,
    this.disabled = false,
    required this.onPressed,
    // this.minimumSize = const Size(60.0, 30.0),
    this.backgroundColor = ExploreaColors.yellow,
    this.mainColor = ExploreaColors.purple,
    this.text,
  }) : super(key: key);

  final bool disabled;
  final Function() onPressed;
  // final Size minimumSize;
  Color backgroundColor;
  Color mainColor;
  String? text;

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
        HapticFeedback.heavyImpact();

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
          width: this.widget.text != null
              ? (32.0 * this.widget.text!.length)
              : (100),
          height: 50.0,
          alignment: Alignment.center,
          color:
              this.widget.disabled ? ExploreaColors.grey : this.backgroundColor,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0),
              child: this.widget.text != null
                  ? Text(
                      this.widget.text!,
                      style: TextStyle(
                        color: this.widget.mainColor,
                        fontSize: 32.0,
                      ),
                    )
                  : Icon(
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
