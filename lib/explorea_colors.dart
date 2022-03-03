import 'package:flutter/rendering.dart';

class ExploreaColors {
  static const yellow = Color(0xffE8B426); // #F3B817
  static const purple = Color(0xff2E095D); // #5A11B6
  static const purpleLight = Color(0xff6313C9); // #6313C9

  static const lightgrey = Color(0xffCECECE);
  static const grey = Color(0xffF7F7F7);
  static const darkGrey = Color(0xff757575);
}

class ExploreaGradients {
  static const yellow = LinearGradient(colors: [
    Color(0xffFFD972),
    Color(0xffFDBE13),
    Color(0xffCF820F),
  ], stops: [
    0.0,
    55.12,
    104.48
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);

  static const purple = LinearGradient(colors: [
    Color(0xff6B1DCD),
    Color(0xff090112),
  ], begin: Alignment.topLeft, end: Alignment.bottomRight);
}
