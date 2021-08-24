import 'package:flutter/material.dart';

class PassPoints extends StatelessWidget {
  final currentPoint;
  final nbPoints;
  final nextPage;

  /// Displays stepper-like points with an arrow to go to another Widget.
  ///
  /// NB : that `currentPoint` index start at 1.
  const PassPoints(
      {Key? key,
      int this.nbPoints = 1,
      int this.currentPoint = 1,
      Widget? this.nextPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Center(
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Icon>.generate(
                    nbPoints,
                    (index) => Icon(Icons.circle,
                        color: index + 1 == currentPoint
                            ? Colors.black
                            : Colors.grey,
                        size: 12.0))
                // [
                //   Icon(
                //     Icons.circle,
                //     color: Colors.black,
                //     size: 12.0,
                //   ),
                //   Icon(
                //     Icons.circle,
                //     color: Colors.grey,
                //     size: 12.0,
                //   ),
                //   Icon(
                //     Icons.circle,
                //     color: Colors.grey,
                //     size: 12.0,
                //   ),
                //   Icon(
                //     Icons.circle,
                //     color: Colors.grey,
                //     size: 12.0,
                //   ),
                // ],
                ),
            if (nextPage != null)
              IconButton(
                icon: const Icon(Icons.arrow_right_alt),
                iconSize: 40.0,
                onPressed: () => {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => nextPage))
                },
              ),
          ],
        ),
      ),
    );
  }
}
