import 'package:basic_utils/basic_utils.dart';

String formatNumber(double number) {
  var s = StringUtils.reverse(number.toString());
  s = StringUtils.addCharAtPosition(s, " ", 3, repeat: true);
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
