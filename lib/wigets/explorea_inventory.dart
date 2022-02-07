import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../explorea_colors.dart';

class ExploreaInventory extends StatelessWidget {
  ExploreaInventory({
    Key? key,
    required this.currentInventory,
    required this.itemMatching,
    this.onItemSelected,
    this.selectedItem,
  }) : super(key: key);

  final List<String> currentInventory;
  final Map<String, String> itemMatching;

  final String? Function()? onItemSelected;
  final String? selectedItem;

  // double height;
  // double width;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 1,
        sigmaY: 1,
      ),
      child: Container(
        color: ExploreaColors.yellow.withOpacity(0.75),
        height: 300,
        width: 300,
        child: SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 8.0,
            children: this.buildItemList(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildItemList() {
    List<Widget> retList = [];

    for (var ind = 0; ind < this.currentInventory.length; ind++) {
      String? matchingAsset = this.itemMatching[this.currentInventory[ind]];
      if (matchingAsset != null) {
        retList.add(Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: Container(
                width: 64.0,
                height: 64.0,
                // color: ExploreaColors.yellow,
                decoration: BoxDecoration(
                    color: ExploreaColors.purple,
                    gradient: RadialGradient(
                      colors: [
                        ExploreaColors.purple,
                        Colors.white.withOpacity(0.0)
                      ],
                      radius: 0.5,
                    ),
                    image: DecorationImage(
                        image: AssetImage(matchingAsset), fit: BoxFit.contain)),
              ),
              onTap: () {
                // TODO: verif it's the name of the item, not the path
                log("selected item : " + this.currentInventory[ind].toString());
              },
            )));
      }
    }
    return retList;
  }
}
