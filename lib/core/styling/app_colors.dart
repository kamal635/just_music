import 'package:flutter/material.dart';

abstract class AppColor {
  ///************************* Colors ******************/
  static const Color primary = Color(0xFF0C2530);
  static const Color black = Color(0xFF000000);
  static const Color blue = Color(0xFF2C6DDE);
  static const Color pink = Color(0xFFAB1477);
  static const Color white = Color(0xFFffffff);

  ///************************* Shade ******************/
  static const MaterialAccentColor primaryShade = MaterialAccentColor(
    0xFF0C2530,
    <int, Color>{
      100: Color.fromARGB(255, 32, 93, 119),
      200: Color.fromARGB(255, 22, 65, 83),
    },
  );

  ///************************* LinearGradient ******************/
  static LinearGradient linearButton = const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        AppColor.blue,
        AppColor.pink,
      ]);
}
