import 'package:flutter/material.dart';

const tabletMinWidthBreakpoint = 650;
const tabletMaxWidthBreakpoint = 1024;

extension ScreenMeasurements on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;

  double get screenWidth => MediaQuery.of(this).size.width;

  double get paddingTop => MediaQuery.of(this).padding.top;

  double get paddingBottom => MediaQuery.of(this).padding.bottom;

  bool get isMobile =>
      MediaQuery.of(this).size.width <= tabletMaxWidthBreakpoint;

  bool get isDesktop =>
      MediaQuery.of(this).size.width > tabletMaxWidthBreakpoint;
}
