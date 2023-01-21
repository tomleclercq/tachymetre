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

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 250,
      ),
    );
    _controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (_data.length >= widget.width) {
      debugPrint('removed _data[${_data.length}]: ${_data.last}');
      _data.removeLast();
    }
    final input = widget.input;
    _data.insert(0, input);

    return CustomPaint(
      willChange: true,
      painter: GraphPainter(
        data: _data,
        listenable: _controller!,
      ),
      child: widget.child,
    );
  }
}
