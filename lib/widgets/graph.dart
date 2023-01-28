import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tachymetre/widgets/graph_painter.dart';

import '../models/data_point.dart';

class Graph extends StatefulWidget {
  const Graph({
    required this.input,
    required this.history,
    required this.width,
    this.child,
    super.key,
  });

  final double input;
  final List<DataPoint> history;
  final double width;
  final Widget? child;

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation? _animation;
  final List<double> _data = [];
  String timestamp = DateTime.now().toIso8601String();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 700,
      ),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 3.0,
    ).animate(_controller!);
    //_controller?.repeat();

    _animation?.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.dismissed:
          _controller?.forward();
          break;
        case AnimationStatus.forward:
          break;
        case AnimationStatus.reverse:
          break;
        case AnimationStatus.completed:
          _controller?.reverse();
          break;
      }
    });

    _controller?.forward();

    Timer.periodic(const Duration(milliseconds: 250), (timer) {
      addDataPoint(widget.input);
      setState(() {
        timestamp = DateTime.now().toIso8601String();
      });
    });
  }

  void addDataPoint(double data) {
    if (_data.length >= 870) {
      _data.removeLast();
    }
    _data.insert(0, data);
  }

  @override
  Widget build(BuildContext context) {
    addDataPoint(widget.input);
    return CustomPaint(
      willChange: true,
      painter: GraphPainter(
        context,
        data: _data,
        history: widget.history,
        timestamp: timestamp,
        listenable: _animation!,
      ),
      child: widget.child,
    );
  }
}
