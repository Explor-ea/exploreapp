import 'package:flutter/material.dart';

/// @see https://stackoverflow.com/a/60730085/13880103
class ExploreaThrowableContainer extends StatefulWidget {
  const ExploreaThrowableContainer({
    Key? key,
    required this.child,
    required this.onThrowed,
  }) : super(key: key);

  @override
  _ExploreaThrowableContainerState createState() =>
      _ExploreaThrowableContainerState();

  final Widget child;
  final Function() onThrowed;
}

class _ExploreaThrowableContainerState extends State<ExploreaThrowableContainer>
    with SingleTickerProviderStateMixin {
  // SingleTickerProviderStateMixin for vsync I think

  var tween = Tween<Offset>(begin: Offset.zero, end: Offset(0, -10))
      .chain(CurveTween(curve: Curves.easeOut));

  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animationController.drive(tween),
      child: GestureDetector(
        child: this.widget.child,
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity != null && details.primaryVelocity! < 0)
            this.animationController.forward().then((value) {
              this.widget.onThrowed();
            });
        },
      ),
    );
  }
}
