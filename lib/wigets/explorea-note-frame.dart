import 'package:exploreapp/explorea_colors.dart';
import 'package:flutter/material.dart';

class ExploreaNoteFrame extends StatelessWidget {
  const ExploreaNoteFrame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: new NoteShape(),
      child: Container(
        // color: ExploreaColors.purple,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/icon/explorea-logo.png"),
          fit: BoxFit.fill,
        )),
        width: 200.0,
        height: 300.0,

        child: Text("test"),
      ),
    );
  }
}

class NoteShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final edgeCut = size.width * 0.154;

    final path = Path();
    path.lineTo(size.width - edgeCut, 0);
    path.lineTo(size.width, 0 + edgeCut);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(NoteShape oldClipper) => false;
}
