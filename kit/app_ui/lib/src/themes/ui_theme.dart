import 'package:flutter/material.dart';

abstract class UITheme {
  ThemeData get theme;

  TextTheme get textTheme;

  ColorScheme get colorScheme;
}
