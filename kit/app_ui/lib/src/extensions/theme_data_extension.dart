import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

extension ThemeDataExtension on ThemeData {
  UIIcon get icons {
    final isDarkMode = brightness == Brightness.dark;
    if (isDarkMode) {
      return UIIconDark();
    } else {
      return UIIconLight();
    }
  }

  UIColor get colors {
    final isDarkMode = brightness == Brightness.dark;
    if (isDarkMode) {
      return UIColorDark();
    } else {
      return UIColorLight();
    }
  }

  UIButtonStyle get buttons {
    final isDarkMode = brightness == Brightness.dark;
    if (isDarkMode) {
      return UIButtonStyleDark();
    } else {
      return UIButtonStyleLight();
    }
  }
}
