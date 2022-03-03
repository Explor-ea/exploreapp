import 'dart:developer';
import 'dart:ui';

import 'package:exploreapp/pages/adventures/adventure_1_gulls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../explorea_colors.dart';

class ExploreaTipsFrame extends StatefulWidget {
  ExploreaTipsFrame({
    Key? key,
    required this.tips,
    this.unlockedTips,
    required this.onClose,
  }) :
        // assert(unlockedTips != null && unlockedTips.length != tips.length,
        //           "The unlockedTips List length must correspond to the tips List length."),
        super(key: key);

  final List<String> tips;

  /// You can hide a tip if a false correspond to the index of the [tips].
  final List<bool>? unlockedTips;
  final Function() onClose;

  @override
  State<ExploreaTipsFrame> createState() => _ExploreaTipsFrameState();
}

class _ExploreaTipsFrameState extends State<ExploreaTipsFrame> {
  /// The current displayed tip.
  int currenTip = 0;

  @override
  void initState() {
    // Set the currenTip to the last unlocked.
    if (this.widget.unlockedTips != null) {
      int indexOfNewestUnlockedTip = this
          .widget
          .unlockedTips!
          .lastIndexWhere((element) => element == true);
      if (indexOfNewestUnlockedTip >= 0 &&
          indexOfNewestUnlockedTip < this.widget.tips.length)
        this.currenTip = indexOfNewestUnlockedTip;
    }
  }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Icon(Icons.close, color: Colors.white, size: 24.0),
                    onTapDown: (tapDownDetails) {
                      HapticFeedback.heavyImpact();

                      this.widget.onClose();
                    },
                  ),
                )
              ],
            ),

            //

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Indices",
                  style: TextStyle(color: Colors.white, fontSize: 32.0),
                )
              ],
            ),

            Container(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        (this.currenTip + 1).toString(),
                        style: TextStyle(
                            color: ExploreaColors.purpleDark, fontSize: 24.0),
                      )),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ExploreaColors.yellow,
                  ),
                )
              ],
            ),

            Container(height: 12),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          this.widget.tips[this.currenTip],
                          style: TextStyle(
                              color: this.widget.unlockedTips != null
                                  ? this.widget.unlockedTips![this.currenTip]
                                      ? Colors.white
                                      : Colors.transparent
                                  : Colors.white,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //

            Container(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0.0, 0.0, 12),
                  child: GestureDetector(
                    onTapDown: (tapDetails) {
                      HapticFeedback.heavyImpact();

                      if (this.currenTip - 1 >= 0)
                        setState(() {
                          this.currenTip--;
                        });
                    },
                    child: this.currenTip > 0
                        ? Text(
                            "Indice précédent",
                            style: TextStyle(
                                color: ExploreaColors.yellow, fontSize: 16),
                          )
                        : Container(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 12, 12),
                  child: GestureDetector(
                    onTapDown: (tapDetails) {
                      HapticFeedback.heavyImpact();

                      if (this.currenTip + 1 < this.widget.tips.length)
                        setState(() {
                          this.currenTip++;
                        });
                    },
                    child: this.currenTip < this.widget.tips.length - 1
                        ? Text(
                            "Indice suivant",
                            style: TextStyle(
                                color: ExploreaColors.yellow, fontSize: 16),
                          )
                        : Container(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
