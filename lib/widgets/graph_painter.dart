import 'package:flutter/material.dart';

class GraphPainter extends CustomPainter {
  GraphPainter({required this.listenable, required this.data})
      : super(repaint: listenable);

  final Animation listenable;
  final List<double> data;

  @override
  void paint(Canvas canvas, Size size) {
    //return;
    double value = listenable.value;
    final height = size.height;
    final width = size.width - 1;

    var paint = Paint()..color = const Color.fromARGB(255, 255, 198, 28);
    paint.strokeWidth = 3;

    var paintRed = Paint()..color = const Color.fromARGB(255, 238, 118, 176);
    paintRed.strokeWidth = 3;

    const heightFactor = 0.85;
    int step = (2.0 * value).ceil();
    for (double i = width; i >= 0; i -= step) {
      final index = i.toInt();
      if (index > data.length) continue;
      if (index - step < 0) continue;

      final f1 = data[index];
      final f0 = data[index - step];

      final heightOffset = height * 1.1;

      canvas.drawLine(
        Offset(
          width - i,
          heightOffset - f0 * heightFactor,
        ),
        Offset(
          width - i - step,
          heightOffset - f1 * heightFactor,
        ),
        index < 15 ? paintRed : paint,
      );
    }
  }

  @override
  bool shouldRepaint(GraphPainter oldDelegate) {
    return oldDelegate.data.first != data.first ;
  }
}
