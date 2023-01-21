import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tachymetre/widgets/graph_painter.dart';

class Graph extends StatefulWidget {
  const Graph({
    required this.input,
    required this.width,
    this.child,
    super.key,
  });

  final double width;
  final double input;
  final Widget? child;

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  final List<double> _data = [];
  String timestamp = DateTime.now().toIso8601String();

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(milliseconds: 250), (timer) {
      addDataPoint(widget.input);
      setState(() {
        timestamp = DateTime.now().toIso8601String();
      });
    });
  }

  void addDataPoint(double data) {
    if (_data.length >= widget.width) {
      debugPrint('removed _data[${_data.length}]: ${_data.last}');
      _data.removeLast();
    }
    _data.insert(
      0,
      data,
    );
  }

  @override
  Widget build(BuildContext context) {
    addDataPoint(widget.input);
    return CustomPaint(
      willChange: true,
      painter: GraphPainter(
        data: _data,
        timestamp: timestamp,
      ),
      child: widget.child,
    );
  }
}
