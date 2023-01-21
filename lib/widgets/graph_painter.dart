import 'package:flutter/material.dart';

class GraphPainter extends CustomPainter {
  GraphPainter({
    required this.data,
    required this.timestamp,
  }) : super();
  final String timestamp;
  final List<double> data;

  @override
  void paint(Canvas canvas, Size size) {
    //return;
    final height = size.height;
    final width = size.width;
    const heightFactor = 0.85;

    var paint = Paint()..color = const Color.fromARGB(255, 248, 224, 154);
    paint.strokeWidth = 3;
    var paintAxis = Paint()..color = const Color.fromARGB(255, 170, 170, 170);
    paint.strokeWidth = 1;

    int step = 1; //max(1, (10.0 * value).ceil());
    for (int i = data.length - 1; i >= 0; i -= step) {
      final index = i.toInt();
      if (index - step < 0) continue;

      final f1 = data[index];
      final f0 = data[index - step];

      final d0 = Offset(
        width - i,
        height - f0 * heightFactor,
      );
      final d1 = Offset(
        width - i - step,
        height - f1 * heightFactor,
      );

      canvas.drawLine(d0, d1, paint);
      if (index < 2) {
        canvas.drawCircle(d1, 5.0, paint);
      }
    }
    final a0 = Offset(
      0,
      height + 1 * heightFactor,
    );
    final a1 = Offset(
      width,
      height + 1 * heightFactor,
    );
    final b0 = Offset(
      0,
      height - 121 * heightFactor,
    );
    final b1 = Offset(
      width,
      height - 121 * heightFactor,
    );
    canvas.drawLine(a0, a1, paintAxis);
    canvas.drawLine(b0, b1, paintAxis);
  }

  @override
  bool shouldRepaint(GraphPainter oldDelegate) {
    return oldDelegate.timestamp != timestamp;
  }
}
