import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

extension Responsive on BuildContext {
  double get h => MediaQuery.of(this).size.height;
  double get w => MediaQuery.of(this).size.width;

  T responsive<T>(T defaultValue, {T? sm, T? md, T? lg, T? xl}) {
    final w = MediaQuery.of(this).size.width;
    return w >= 1280
        ? (xl ?? lg ?? md ?? sm ?? defaultValue)
        : w >= 1024
            ? (lg ?? md ?? sm ?? defaultValue)
            : w >= 768
                ? (md ?? sm ?? defaultValue)
                : w >= 640
                    ? (sm ?? defaultValue)
                    : defaultValue;
  }

  void routing(Widget route) {
    Navigator.pushReplacement(
        this,
        PageTransition(
            type: PageTransitionType.leftToRightWithFade, child: route));
  }
}

extension PaddingSpace on num {
  SizedBox get ph => SizedBox(height: this.toDouble(),);
  SizedBox get pw=> SizedBox(width: this.toDouble());
}
