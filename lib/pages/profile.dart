import 'package:flutter/material.dart';

import '../explorea_colors.dart';

class Profil extends StatelessWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  backgroundColor: ExploreaColors.purple,
                  onPressed: () {},
                  child: new Icon(Icons.settings),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  backgroundColor: ExploreaColors.purple,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: new Icon(Icons.close),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
