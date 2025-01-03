import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color.fromRGBO(215, 38, 56, 1);
  static const Color primaryVariant = Color.fromRGBO(215, 38, 56, 1);
  static const Color secondary = Color.fromRGBO(38, 154, 248, 1);
  static const Color secondaryVariant = Color.fromRGBO(38, 154, 248, 1);

  static const Color background = Color(0xFFF6F6F6);

  static const Color black = Color.fromARGB(255, 0, 0, 0);
  static const Color white = Color.fromARGB(255, 255, 255, 255);
  static const Color surface = Color.fromARGB(255, 0, 0, 0);
  static const Color error = Color(0xFFB00020);

  static const Color onPrimary = Color.fromRGBO(243, 243, 243, 1);
  static const Color onSecondary = Color.fromRGBO(20, 20, 20, 1);
  static const Color onBackground = Color.fromRGBO(20, 20, 20, 1);
  static const Color onSurface = Color.fromRGBO(20, 20, 20, 1);
  static const Color onError = Color(0xFFB00020);

  static const LinearGradient backGroundGradient = LinearGradient(
    colors: [
      Color.fromRGBO(20, 20, 20, 1),
      Color.fromRGBO(26, 26, 26, 1),
      Color.fromRGBO(15, 15, 15, 1),
    ],
    begin: FractionalOffset.topCenter,
    end: FractionalOffset.bottomCenter,
    tileMode: TileMode.clamp,
  );
}
