import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

extension ThemeDataExtension on ThemeData {
  UIIcon get icons {
    final isDarkMode = brightness == Brightness.dark;
    if (isDarkMode) {
      return UIIconDark.instance;
    } else {
      return UIIconLight.instance;
    }
  }

  UIColor get colors {
    final isDarkMode = brightness == Brightness.dark;
    if (isDarkMode) {
      return UIColorDark.instance;
    } else {
      return UIColorLight.instance;
    }
  }

  UIAsset get assets {
    final isDarkMode = brightness == Brightness.dark;
    if (isDarkMode) {
      return UIAssetDark.instance;
    } else {
      return UIAssetLight.instance;
    }
  }

  UIButtonStyle get buttonStyles {
    final isDarkMode = brightness == Brightness.dark;
    if (isDarkMode) {
      return UIButtonStyleDark.instance;
    } else {
      return UIButtonStyleLight.instance;
    }
  }

  UIInputStyle get inputStyles {
    final isDarkMode = brightness == Brightness.dark;
    if (isDarkMode) {
      return UIInputStyleDark.instance;
    } else {
      return UIInputStyleLight.instance;
    }
  }

  UITextStyle get textStyles {
    final isDarkMode = brightness == Brightness.dark;
    if (isDarkMode) {
      return UITextStyleDark.instance;
    } else {
      return UITextStyleLight.instance;
    }
  }
}
