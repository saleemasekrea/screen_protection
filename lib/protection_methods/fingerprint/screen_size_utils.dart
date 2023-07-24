import 'package:flutter/material.dart';

class ScreenSizeUtils {
  static double calculateFontSize(BuildContext context, double height) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    return screenHeight * height;
  }

  static double calculateCircleSize(BuildContext context, double height) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final appBar = AppBar();
    final appBarHeight = appBar.preferredSize.height;
    final statusBarHeight = mediaQuery.padding.top;
    final availableHeight = screenHeight - appBarHeight - statusBarHeight;
    return availableHeight * height;
  }
}
