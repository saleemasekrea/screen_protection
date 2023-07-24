import 'package:flutter/material.dart';

onSelect({var circle, var dots}) {
  if (dots.isEmpty || !dots.contains(circle)) {
    dots.add(circle);
  }
}

clearDots({required Offset offset, required List<int> dots}) {
  dots.clear();
  offset = const Offset(0, 0);
}

Offset coordinatesOf(int i, double sizeDot, int dimension) {
  double _dx = sizeDot * (i % dimension + 0.5);
  double _dy = sizeDot * ((i / dimension).floor() + 0.5);
  return Offset(_dx, _dy);
}

Color colorOf(int i, List<int> dots) {
  return dots.contains(i) ? Colors.indigoAccent : Colors.white;
}

Path getCirclePath(Offset offset, double radius) {
  Rect _rect = Rect.fromCircle(radius: radius, center: offset);
  return Path()..addOval(_rect);
}

void drawCircle(
    Canvas canvas, Offset offset, double radius, Color color, Paint painter,
    [bool isDot = false]) {
  Path _path = getCirclePath(offset, radius);
  Paint _painter = painter
    ..color = color
    ..style = isDot ? PaintingStyle.fill : PaintingStyle.stroke;
  canvas.drawPath(_path, _painter);
}

void drawLine(Canvas canvas, Offset start, Offset end, Paint painter) {
  Paint _painter = painter
    ..color = Colors.indigoAccent
    ..style = PaintingStyle.stroke
    ..strokeWidth = 5;
  Path _path = Path();
  _path.moveTo(start.dx, start.dy);
  _path.lineTo(end.dx, end.dy);
  canvas.drawPath(_path, _painter);
}
