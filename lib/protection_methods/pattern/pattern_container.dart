import 'package:flutter/material.dart';

import 'package:screen_protection/protection_methods/pattern/pattern_painter.dart';
import 'package:screen_protection/protection_methods/pattern/functions.dart';

class PatternContainer extends StatefulWidget {
  final List<int> dots;
  final int dimension;
  final Offset offset;
  final double sideLength;
  final double margin;
  const PatternContainer({
    super.key,
    required this.dots,
    required this.dimension,
    required this.offset,
    required this.sideLength,
    required this.margin,
  });

  @override
  State<PatternContainer> createState() => _PatternContainerState(
        dots: dots,
        dimension: dimension,
        offset: offset,
        sideLength: sideLength,
        margin: margin,
      );
}

class _PatternContainerState extends State<PatternContainer> {
  List<int> dots;
  int dimension;
  Offset offset;
  double sideLength;
  double margin;
  _PatternContainerState({
    required this.dots,
    required this.dimension,
    required this.offset,
    required this.sideLength,
    required this.margin,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.circular(15),
      ),
      child: GestureDetector(
        onPanStart: (details) {
          clearDots(
            dots: dots,
            offset: offset,
          );
          setState(() {});
        },
        onPanUpdate: (details) {
          offset = details.localPosition;
          setState(() {});
        },
        onPanEnd: (details) {
          offset = dots.length > 0
              ? coordinatesOf(dots[dots.length - 1],
                  (sideLength - margin) / dimension, dimension)
              : Offset(0, 0);
          setState(() {});
        },
        child: CustomPaint(
          painter: PatternPainter(
            dimension: dimension,
            dots: dots,
            offset: offset,
            onSelect: (circle) {
              onSelect(
                circle: circle,
                dots: dots,
              );
            },
          ),
          size: Size(
            sideLength,
            sideLength,
          ),
        ),
      ),
    );
  }
}
