import 'package:flutter/material.dart';

import '../explorea_colors.dart';

class ExploreaBtn extends StatelessWidget {
  const ExploreaBtn({
    Key? key,
    this.disabled = false,
    required this.icon,
    required this.onPressed,
    this.minimumSize = const Size(60.0, 60.0),
  }) : super(key: key);

  final bool disabled;
  final IconData icon;
  final Function() onPressed;
  final Size minimumSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: this.onPressed,
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        primary: this.disabled == true ? Colors.grey : ExploreaColors.purple,
        minimumSize: this.minimumSize,
      ),
      child: Icon(
        icon,
        color: ExploreaColors.yellow,
      ),
    );
  }
}
