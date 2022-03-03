import 'dart:developer';
import 'dart:ui';

import 'package:exploreapp/pages/adventures/adventure_1_gulls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../explorea_colors.dart';

class ExploreaNotificationFrame extends StatefulWidget {
  ExploreaNotificationFrame({
    Key? key,
    required this.message,
    required this.repLeft,
    this.repRight,
    required this.onCloseLeft,
    this.onCloseRight,
  }) : super(key: key);

  final String message;
  final String repLeft;
  final String? repRight;
  final Function() onCloseLeft;
  final Function()? onCloseRight;

  @override
  State<ExploreaNotificationFrame> createState() =>
      _ExploreaNotificationFrameState();
}

class _ExploreaNotificationFrameState extends State<ExploreaNotificationFrame> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 1,
        sigmaY: 1,
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [ExploreaColors.purple, ExploreaColors.purpleDark],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
        ),
        height: 400,
        width: 300,
        child: Column(
          children: [
            //

            Container(height: 24),

            //

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error,
                  color: ExploreaColors.yellow,
                  size: 75,
                )
              ],
            ),

            //

            Container(height: 24),

            //

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          this.widget.message,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //

            Container(height: 12),

            //

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTapDown: (tapDetails) {
                    HapticFeedback.heavyImpact();
                    this.widget.onCloseLeft();
                  },
                  child: Text(
                    this.widget.repLeft,
                    style:
                        TextStyle(color: ExploreaColors.yellow, fontSize: 18),
                  ),
                ),
                if (this.widget.repRight != null)
                  GestureDetector(
                    onTapDown: (tapDetails) {
                      HapticFeedback.heavyImpact();
                      if (this.widget.onCloseRight != null)
                        this.widget.onCloseRight!();
                    },
                    child: Text(
                      this.widget.repRight!,
                      style:
                          TextStyle(color: ExploreaColors.yellow, fontSize: 18),
                    ),
                  ),
              ],
            ),

            //

            Container(
              height: 12.0,
            )

            //
          ],
        ),
      ),
    );
  }
}
