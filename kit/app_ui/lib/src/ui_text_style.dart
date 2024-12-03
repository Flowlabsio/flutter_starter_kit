import 'package:app_ui/src/src.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UITextStyle {
  static final _baseTextStyle = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontWeight: UIFontWeight.regular,
  );

  static TextStyle get displayLarge {
    return _baseTextStyle.copyWith(
      fontSize: 57,
    );
  }

  static TextStyle get displayMedium {
    return _baseTextStyle.copyWith(
      fontSize: 45,
    );
  }

  static TextStyle get displaySmall {
    return _baseTextStyle.copyWith(
      fontSize: 36,
    );
  }

  static TextStyle get headlineLarge {
    return _baseTextStyle.copyWith(
      fontSize: 32,
    );
  }

  static TextStyle get headlineMedium {
    return _baseTextStyle.copyWith(
      fontSize: 28,
    );
  }

  static TextStyle get headlineSmall {
    return _baseTextStyle.copyWith(
      fontSize: 24,
    );
  }

  static TextStyle get titleLarge {
    return _baseTextStyle.copyWith(
      fontSize: 22,
    );
  }

  static TextStyle get titleMedium {
    return _baseTextStyle.copyWith(
      fontSize: 16,
    );
  }

  static TextStyle get titleSmall {
    return _baseTextStyle.copyWith(
      fontSize: 14,
    );
  }

  static TextStyle get labelLarge {
    return _baseTextStyle.copyWith(
      fontSize: 14,
    );
  }

  static TextStyle get labelMedium {
    return _baseTextStyle.copyWith(
      fontSize: 12,
    );
  }

  static TextStyle get labelSmall {
    return _baseTextStyle.copyWith(
      fontSize: 11,
    );
  }

  static TextStyle get bodyLarge {
    return _baseTextStyle.copyWith(
      fontSize: 16,
    );
  }

  static TextStyle get bodyMedium {
    return _baseTextStyle.copyWith(
      fontSize: 14,
    );
  }

  static TextStyle get bodySmall {
    return _baseTextStyle.copyWith(
      fontSize: 12,
    );
  }
}
