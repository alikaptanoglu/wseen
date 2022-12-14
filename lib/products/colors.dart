// ignore_for_file: use_full_hex_values_for_flutter_colors
import 'package:flutter/material.dart';

class ProjectColors {
  static Color customColor = Colors.white;
  static Color transparent = Colors.transparent;

  static Color greyColor = Colors.grey;
  static Color themeColorDEF = const Color.fromARGB(255, 240, 240, 240);
  static Color themeColorMOD1 = const Color.fromARGB(255, 200, 200, 200);
  static Color themeColorMOD2 = const Color.fromARGB(255, 220, 220, 220);
  static Color themeColorMOD3 = const Color.fromARGB(255, 21, 21, 29);
  static Color themeColorMOD4 = const Color.fromARGB(255, 31,33,46);
  static Color themeColorMOD5 = const Color(0xffbff9a5c);

  static Color menuColor = const Color.fromARGB(255, 20, 20, 20);
  static Color iconColor = const Color.fromARGB(255, 107, 109, 255);

  static Color opacityDEFw(double value) => Colors.white.withOpacity(value);
  static Color opacityDEFb(double value) => Colors.black.withOpacity(value);

  static Color onlineColor = Colors.green;
  static Color offlineColor = Colors.red;

  static LinearGradient whitetoTransparent = LinearGradient(
      colors: [ProjectColors.customColor, ProjectColors.transparent],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);

  static LinearGradient gradient() {
    return const LinearGradient(colors: [
      Color.fromARGB(255, 21, 21, 29),
      Color.fromARGB(255, 24, 20, 36),
      Color.fromARGB(255, 34, 24, 59),
      //Color.fromARGB(255, 32, 23, 47),
      Color.fromARGB(255, 31, 32, 64),
    ], begin: Alignment.bottomCenter, end: Alignment.topCenter);
  }


  // static LinearGradient paymentGradient() {
  //   return LinearGradient(colors: [
  // ProjectColors.themeColorMOD3,
  // const Color.fromARGB(255, 24, 20, 36),
  // const Color.fromARGB(255, 34, 24, 59),
  //   //Color.fromARGB(255, 32, 23, 47),
  // const Color.fromARGB(255, 31, 32, 64),
  // ],begin: Alignment.bottomCenter,end: Alignment.topCenter);
  // }
}
