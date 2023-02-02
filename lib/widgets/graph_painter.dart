import 'package:flutter/material.dart';
import 'package:tachymetre/utils/utils.dart';

import '../models/data_point.dart';

class GraphPainter extends CustomPainter {
  GraphPainter(
    this.context, {
    required this.data,
    required this.history,
    required this.timestamp,
    required this.listenable,
  }) : super(repaint: listenable);

  BuildContext context;
  final String timestamp;
  final List<double> data;
  final List<DataPoint> history;
  final Animation listenable;
  final heightFactor = 0.85;

  void drawAxis(
    Canvas canvas, {
    required Color color,
    required double xMin,
    required double xMax,
    required double yMin,
    required double yMax,
    required double yValue,
    int dashLength = 0,
  }) {
    Paint paintAxis = Paint()..color = color;
    paintAxis.strokeWidth = 1;
    paintAxis.style = PaintingStyle.stroke;
    if (dashLength > 0) {
      final count = (xMax - xMin) / dashLength / 2;

      for (int i = 0; i < count; i++) {
        final p0 = Offset(
          (i * dashLength).toDouble() * 2,
          yMin - yValue * heightFactor,
        );
        final p1 = Offset(
          (i * dashLength).toDouble() * 2 + dashLength,
          yMax - yValue * heightFactor,
        );
        canvas.drawLine(p0, p1, paintAxis);
      }
    } else {
      final p0 = Offset(
        xMin,
        yMin - yValue * heightFactor,
      );
      final p1 = Offset(
        xMax,
        yMax - yValue * heightFactor,
      );
      canvas.drawLine(p0, p1, paintAxis);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    double value = listenable.value;
    final height = size.height;
    final width = size.width;

    var paint = Paint()..color = AppColors.line;
    var paint2 = Paint()..color = AppColors.point;
    paint.strokeWidth = 3;
    paint.strokeCap = StrokeCap.round;
    paint.strokeJoin = StrokeJoin.round;

    for (int i = history.length; i >= 1; i--) {
      final dataTime = history[history.length - i].positionData!.timestamp!;
      final time0 = DateTime.now();
      final time1 = time0.subtract(const Duration(minutes: 15));
      if (dataTime.isBefore(time1)) {
        continue;
      }

      ///x:
      ///time0: x = width
      ///time1: x =
      final x =
          width - time0.difference(dataTime).inSeconds.toDouble(); //* (width);
      final d0 = Offset(
        x,
        height -
            history[history.length - i].positionData!.speed.toKmph *
                heightFactor,
      );
      canvas.drawCircle(d0, 3.0, paint2);
    }

    const step = 1;
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

    drawAxis(
      canvas,
      color: AppColors.axisMin,
      xMin: 0,
      xMax: width,
      yMin: height,
      yMax: height,
      yValue: -1,
    );
    drawAxis(
      canvas,
      color: AppColors.axis30,
      xMin: 0,
      xMax: width,
      yMin: height,
      yMax: height,
      yValue: 29,
      dashLength: 4,
    );
    drawAxis(
      canvas,
      color: AppColors.axis50,
      xMin: 0,
      xMax: width,
      yMin: height,
      yMax: height,
      yValue: 49,
      dashLength: 4,
    );
    drawAxis(
      canvas,
      color: AppColors.axis70,
      xMin: 0,
      xMax: width,
      yMin: height,
      yMax: height,
      yValue: 69,
      dashLength: 4,
    );
    drawAxis(
      canvas,
      color: AppColors.axis100,
      xMin: 0,
      xMax: width,
      yMin: height,
      yMax: height,
      yValue: 99,
      dashLength: 4,
    );
    drawAxis(
      canvas,
      color: AppColors.axisMax,
      xMin: 0,
      xMax: width,
      yMin: height,
      yMax: height,
      yValue: 121,
    );
    const maxSpeed = 120;

    int sampleCount = 2;
    double average = 0;
    double totalSpeed =
        data.getRange(0, sampleCount - 1).fold(0, (p, c) => p + c);
    if (totalSpeed > 0) {
      average = totalSpeed / sampleCount;
    }
    if ((data.first >= maxSpeed + 5 || average > maxSpeed) && value % 2 == 0) {
      final Paint paint = Paint();
      paint.color = Color.lerp(
            const Color.fromARGB(0, 255, 255, 255),
            const Color.fromARGB(255, 255, 255, 255),
            data.first / maxSpeed,
          ) ??
          const Color(0x00000000);
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(width / 2, height / 2),
          width: 1080,
          height: 2400,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(GraphPainter oldDelegate) {
    return oldDelegate.timestamp != timestamp;
  }
}
