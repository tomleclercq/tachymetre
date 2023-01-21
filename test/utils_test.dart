import 'package:flutter_test/flutter_test.dart';
import 'package:tachimeter/utils.dart';

void main() {
  test('utils ...', () {
    List<double> values = [0.0, 120.4, 54.5, 1.2, 11.87];
    List<String> results = ["000.00", "120.40", "054.50", "001.20", "011.87"];
    for (final result in results) {
      String converted = values[results.indexOf(result)].addLeadingZeros(6);
      expect(converted, equals(result));
    }
  });
}
