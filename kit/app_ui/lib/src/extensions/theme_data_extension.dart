import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

extension ThemeDataExtension on ThemeData {
  UIIcons get icons {
    final isDarkMode = brightness == Brightness.dark;
    if (isDarkMode) {
      return UIIconsDark();
    } else {
      return UIIconsLight();
    }
  }

  UIColors get colors {
    final isDarkMode = brightness == Brightness.dark;
    if (isDarkMode) {
      return UIColorsDark();
    } else {
      return UIColorsLight();
    }
  }
}
