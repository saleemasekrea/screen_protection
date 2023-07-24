import 'package:flutter/material.dart';
import 'package:screen_protection/protection_methods/pattern/functions.dart';

class PatternPainter extends CustomPainter {
  final int dimension;
  Size size = const Size(0, 0);

  final List<int> dots;
  final Offset offset;
  final void Function(int code) onSelect;

  PatternPainter({
    required this.dimension,
    required this.dots,
    required this.offset,
    required this.onSelect,
  });

  double get _dotSize => size.width / dimension;
  double get _dotStroke => _dotSize / 24;

  Paint get _painter => Paint()
    ..color = Colors.white54
    ..strokeWidth = _dotStroke;

  @override
  void paint(Canvas canvas, Size size) {
    this.size = size;

    //draw the dots
    for (int i = 0; i < dimension * dimension; i++) {
      Offset _offset = coordinatesOf(i, _dotSize, dimension);
      Color _color = colorOf(i, dots);

      double _internalRadius = (_dotSize / 3) * 0.3;
      drawCircle(canvas, _offset, _internalRadius, _color, _painter, true);

      double _externalRadius = (_dotSize / 3);
      drawCircle(canvas, _offset, _externalRadius, _color, _painter);

      Path _pathGesture = getCirclePath(_offset, _externalRadius);
      if (_pathGesture.contains(offset)) onSelect(i);
    }

    //connect the dots
    for (int i = 0; i < dots.length; i++) {
      Offset _start = coordinatesOf(dots[i], _dotSize, dimension);
      if (i + 1 < dots.length) {
        Offset _end = coordinatesOf(dots[i + 1], _dotSize, dimension);
        drawLine(canvas, _start, _end, _painter);
      } else {
        Offset _end = offset;
        drawLine(canvas, _start, _end, _painter);
      }
    }
  }

  @override
  bool shouldRepaint(PatternPainter oldDelegate) {
    return offset != oldDelegate.offset;
  }
}
