import 'package:flutter/material.dart';

import '../explorea_colors.dart';

class ExploreaFab extends StatelessWidget {
  const ExploreaFab({
    Key? key,
    required this.padding,
    this.color = ExploreaColors.purple,
    required this.onPressed,
    this.icon,
  }) : super(key: key);

  /// Something like `const EdgeInsets.all(8.0)`
  final EdgeInsetsGeometry padding;

  /// Something like `ExploreaColors.purple`
  final Color color;
  final Function() onPressed;

  /// Something like `new Icon(Icons.close)`
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: this.padding,
      child: FloatingActionButton(
        heroTag: null,
        backgroundColor: this.color,
        onPressed: this.onPressed,
        child: this.icon,
      ),
    );
  }
}
