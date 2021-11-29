import 'package:flutter/material.dart';

import '../explorea_colors.dart';
import '../main.dart';

class ExploreaGotoIcon extends StatelessWidget {
  const ExploreaGotoIcon({
    Key? key,
    this.nextPage,
    this.icon = Icons.chevron_right,
  }) : super(key: key);

  final Widget? nextPage;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (unusedDetails) {
        if (this.nextPage != null) goToNextPage(context, this.nextPage!);
      },
      child: Container(
          width: 50,
          child: Icon(
            this.icon,
            color: nextPage != null ? ExploreaColors.yellow : Colors.grey,
            size: 32,
          )),
    );
  }
}
