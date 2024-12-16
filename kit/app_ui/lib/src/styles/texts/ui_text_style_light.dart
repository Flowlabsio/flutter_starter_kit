import 'package:app_ui/src/src.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UITextStyleLight extends UITextStyle {
  UITextStyleLight._singleton();

  static final UITextStyleLight instance = UITextStyleLight._singleton();

  final UIColor uiColor = UIColorLight.instance;

  @override
  TextStyle get baseTextStyle {
    return TextStyle(
      fontFamily: GoogleFonts.openSans().fontFamily,
      fontWeight: UIFontWeight.regular,
      color: uiColor.onSurface,
    );
  }

  @override
  TextStyle get displayLarge {
    return baseTextStyle.copyWith(
      fontSize: 57,
    );
  }

  @override
  TextStyle get displayMedium {
    return baseTextStyle.copyWith(
      fontSize: 45,
    );
  }

  @override
  TextStyle get displaySmall {
    return baseTextStyle.copyWith(
      fontSize: 36,
    );
  }

  @override
  TextStyle get headlineLarge {
    return baseTextStyle.copyWith(
      fontSize: 32,
    );
  }

  @override
  TextStyle get headlineMedium {
    return baseTextStyle.copyWith(
      fontSize: 28,
    );
  }

  @override
  TextStyle get headlineSmall {
    return baseTextStyle.copyWith(
      fontSize: 24,
    );
  }

  @override
  TextStyle get titleLarge {
    return baseTextStyle.copyWith(
      fontSize: 22,
    );
  }

  @override
  TextStyle get titleMedium {
    return baseTextStyle.copyWith(
      fontSize: 16,
    );
  }

  @override
  TextStyle get titleSmall {
    return baseTextStyle.copyWith(
      fontSize: 14,
    );
  }

  @override
  TextStyle get labelLarge {
    return baseTextStyle.copyWith(
      fontSize: 14,
    );
  }

  @override
  TextStyle get labelMedium {
    return baseTextStyle.copyWith(
      fontSize: 12,
    );
  }

  @override
  TextStyle get labelSmall {
    return baseTextStyle.copyWith(
      fontSize: 11,
    );
  }

  @override
  TextStyle get bodyLarge {
    return baseTextStyle.copyWith(
      fontSize: 16,
    );
  }

  @override
  TextStyle get bodyMedium {
    return baseTextStyle.copyWith(
      fontSize: 14,
    );
  }

  @override
  TextStyle get bodySmall {
    return baseTextStyle.copyWith(
      fontSize: 12,
    );
  }
}
