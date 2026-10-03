import 'package:flutter/material.dart';

/// A single phone-first scale keeps the composition identical on every phone.
/// Only spacing, type, and fixed visual sizes shrink on compact viewports.
extension ResponsiveContext on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get screenWidth => mediaQuery.size.width;
  double get screenHeight => mediaQuery.size.height;
  double get shortestSide => mediaQuery.size.shortestSide;

  bool get isNarrowPhone => shortestSide < 360;
  bool get isShortPhone => screenHeight < 700;
  bool get isCompactPhone => isNarrowPhone || isShortPhone;

  double get phoneScale => (shortestSide / 393).clamp(.82, 1).toDouble();

  double get pagePadding => 24 * phoneScale;

  double get cardPadding => 20 * phoneScale;

  double get horizontalGutter => 18 * phoneScale;

  double get heroHeight {
    final byWidth = shortestSide * .49;
    return byWidth.clamp(145, 210).toDouble();
  }

  double adaptive(
    double designValue, {
    double minScale = .82,
    double maxScale = 1.12,
  }) {
    final scale = phoneScale.clamp(minScale, maxScale);
    return designValue * scale;
  }

  double compactHeight(double value, {double minimum = 0}) {
    return (value * phoneScale).clamp(minimum, value).toDouble();
  }
}
