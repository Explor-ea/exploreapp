import 'dart:developer';
import 'dart:ui';

import 'package:exploreapp/pages/adventures/adventure_1_gulls.dart';
import 'package:flutter/material.dart';

import '../explorea_colors.dart';

class ExploreaInventory extends StatefulWidget {
  ExploreaInventory({
    Key? key,
    required this.currentInventory,
    this.itemSelected,
    this.onItemSelected,
  }) : super(key: key);

  final List<String> currentInventory;
  final String? itemSelected;

  // Tous les items

  final Function(String?)? onItemSelected;

  @override
  State<ExploreaInventory> createState() => _ExploreaInventoryState();
}

class _ExploreaInventoryState extends State<ExploreaInventory> {
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

    int minInventorySize = this.widget.currentInventory.length < 5
        ? 12
        : this.widget.currentInventory.length + 1;

    for (var ind = 0; ind < minInventorySize; ind++) {
      if (ind < this.widget.currentInventory.length) {
        String i_item = this.widget.currentInventory[ind];

        String? matchingAsset = AdventureData.getAssetForItem(i_item);

        retList.add(Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: Container(
                width: 64.0,
                height: 64.0,
                // color: ExploreaColors.yellow,
                decoration: BoxDecoration(
                  border: this.widget.itemSelected == i_item
                      ? Border.all(color: ExploreaColors.yellow, width: 2.0)
                      : null,
                  color: ExploreaColors.purpleLight,
                  image: DecorationImage(
                      image: AssetImage(matchingAsset != null
                          ? matchingAsset
                          : "assets/icon/question_mark.png"),
                      fit: BoxFit.contain),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              onTap: () {
                log("selected item : " + i_item);

                if (this.widget.onItemSelected != null)
                  this.widget.onItemSelected!(i_item);
              },
            )));
      } else
        retList.add(Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: 64.0,
                height: 64.0,
                // color: ExploreaColors.yellow,
                decoration: BoxDecoration(
                  color: ExploreaColors.purpleLight,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ))));
    }
    return retList;
  }
}
