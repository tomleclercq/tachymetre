import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';

class AppColors {
  static Color neutral = const Color.fromARGB(255, 255, 255, 255);
  static Color good = const Color.fromARGB(255, 113, 248, 201);
  static Color warning = const Color.fromARGB(255, 248, 205, 97);
  static Color alert = const Color.fromARGB(255, 255, 87, 124);
  //Graph
  static Color line = const Color.fromARGB(255, 255, 255, 255);
  static Color point = const Color.fromARGB(255, 151, 251, 249);

  ///Axis
  static Color axisMin = const Color.fromARGB(255, 40, 202, 242);
  static Color axis30 = const Color.fromARGB(255, 59, 255, 248);
  static Color axis50 = const Color.fromARGB(255, 40, 242, 148);
  static Color axis70 = const Color.fromARGB(255, 242, 225, 40);
  static Color axis100 = const Color.fromARGB(255, 242, 151, 40);
  static Color axisMax = const Color.fromARGB(255, 242, 40, 40);

  static MaterialColor colorSwatches = const MaterialColor(
    0xFF558B2F,
    <int, Color>{
      50: Color(0xff2C2C2C),
      100: Color(0xFF4C4C4C),
      200: Color(0xFF5C5C5C),
      300: Color(0xFF6C6C6C),
      400: Color(0xFF7C7C7C),
      500: Color(0xFF8C8C8C),
      600: Color(0xFF9C9C9C),
      700: Color(0xFFACACAC),
      800: Color(0xFFBCBCBC),
      900: Color(0xFFCCCCCC),
    },
  );
}

String formatNumber(double number) {
  var s = StringUtils.reverse(number.toString());
  s = StringUtils.addCharAtPosition(s, ' ', 3, repeat: true);
  return StringUtils.reverse(s);
}

extension DoubleExtensions on double {
  ///returns a String with leading zeros.
  ///1 would be with the [numberOfTotalDigits] = 3 lead to a string '001'
  String addLeadingZeros(int numberOfTotalDigits) =>
      toStringAsFixed(2).padLeft(numberOfTotalDigits, '0');

  double get toKmph => this * 3.6;
  double get toMph => this / 3.6;
}

extension IntExtensions on int {
  ///returns a String with leading zeros.
  ///1 would be with the [numberOfTotalDigits] = 3 lead to a string '001'
  String addLeadingZeros(int numberOfTotalDigits) =>
      toStringAsFixed(0).padLeft(numberOfTotalDigits, '0');

  String addLeadingSpace(int numberOfTotalDigits) =>
      toStringAsFixed(0).padLeft(numberOfTotalDigits, ' ');

  double get toKmph => this * 3.6;
  double get toMph => this / 3.6;
}
