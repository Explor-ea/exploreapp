import 'dart:developer';

import 'package:exploreapp/explorea_colors.dart';
import 'package:flutter/material.dart';

class ExploreaCheckbox extends StatefulWidget {
  ExploreaCheckbox(
      {Key? key,
      required this.onChanged,
      this.isChecked = false,
      this.size = 30.0})
      : super(key: key);

  bool isChecked;
  final double size;
  final ValueChanged<bool> onChanged;

  @override
  _ExploreaCheckboxState createState() => _ExploreaCheckboxState();
}

class _ExploreaCheckboxState extends State<ExploreaCheckbox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isChecked = !widget.isChecked;
          widget.onChanged(widget.isChecked);
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        margin:
            const EdgeInsets.only(left: 2.0, top: 2.0, right: 2.0, bottom: 2.0),
        decoration: BoxDecoration(
          color: widget.isChecked ? ExploreaColors.purple : null,
          borderRadius: BorderRadius.circular(5.0),
          border: widget.isChecked
              ? null
              : Border.all(color: ExploreaColors.purple, width: 2.0),
        ),
        width: widget.size,
        height: widget.size,
      ),
    );
  }
}
