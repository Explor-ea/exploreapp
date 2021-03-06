import 'package:exploreapp/explorea_colors.dart';
import 'package:flutter/material.dart';

class ExploreaNoteFrame extends StatelessWidget {
  ///
  /// If a `backgroundAsset` is given, the background will be covered with it.
  const ExploreaNoteFrame({
    Key? key,
    this.backgroundAsset,
    this.width,
    this.height,
    this.backgroundColor = ExploreaColors.purple,
    this.padding = const EdgeInsets.fromLTRB(24, 20, 24, 20),
    this.child,
  }) : super(key: key);

  ///
  /// If
  final String? backgroundAsset;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: new NoteShape(),
      child: Container(
        //
        decoration: backgroundAsset != null
            ? BoxDecoration(
                image: DecorationImage(
                image: AssetImage(this.backgroundAsset!),
                fit: BoxFit.cover,
              ))
            : null,
        color: backgroundAsset == null ? this.backgroundColor : null,
        //
        width: this.width,
        height: this.height,
        child: Padding(
          padding: this.padding,
          child: this.child,
        ),
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

class NoteShapeBottomCut extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final edgeCut = size.width * 0.077;

    final path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - edgeCut);
    path.lineTo(size.width - edgeCut, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(NoteShape oldClipper) => false;
}
