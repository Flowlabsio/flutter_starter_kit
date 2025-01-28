import 'package:app_ui/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

abstract class UIColor {
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color transparent = Color(0x00000000);

  static const _primaryGenerator = 0xFF135986;
  static const _secondaryGenerator = 0xFF86929F;
  static const _tertiaryGenerator = 0xFF998BA8;
  static const _errorGenerator = 0xFFFF5449;
  static const _neutralGenerator = 0xFF909093;
  static const _neutralVariantGenerator = 0xFF8D9197;

  final MaterialColor primarySchema = MaterialColor(
    _primaryGenerator,
    HctColor.generateMaterial3TonesHct(
      Hct.fromInt(_primaryGenerator),
    ),
  );

  final MaterialColor secondarySchema = MaterialColor(
    _secondaryGenerator,
    HctColor.generateMaterial3TonesHct(
      Hct.fromInt(_secondaryGenerator),
    ),
  );

  final MaterialColor tertiarySchema = MaterialColor(
    _tertiaryGenerator,
    HctColor.generateMaterial3TonesHct(
      Hct.fromInt(_tertiaryGenerator),
    ),
  );

  final MaterialColor errorSchema = MaterialColor(
    _errorGenerator,
    HctColor.generateMaterial3TonesHct(
      Hct.fromInt(_errorGenerator),
    ),
  );

  final MaterialColor neutralSchema = MaterialColor(
    _neutralGenerator,
    HctColor.generateMaterial3TonesHct(
      Hct.fromInt(_neutralGenerator),
    ),
  );

  final MaterialColor neutralVariantSchema = MaterialColor(
    _neutralVariantGenerator,
    HctColor.generateMaterial3TonesHct(
      Hct.fromInt(_neutralVariantGenerator),
    ),
  );

  Color get primary;
  Color get onPrimary;
  Color get primaryContainer;
  Color get onPrimaryContainer;
  Color get primaryFixed;
  Color get primaryFixedDim;
  Color get onPrimaryFixed;
  Color get onPrimaryFixedVariant;

  Color get secondary;
  Color get onSecondary;
  Color get secondaryContainer;
  Color get onSecondaryContainer;
  Color get secondaryFixed;
  Color get secondaryFixedDim;
  Color get onSecondaryFixed;
  Color get onSecondaryFixedVariant;

  Color get tertiary;
  Color get onTertiary;
  Color get tertiaryContainer;
  Color get onTertiaryContainer;
  Color get tertiaryFixed;
  Color get tertiaryFixedDim;
  Color get onTertiaryFixed;
  Color get onTertiaryFixedVariant;

  Color get error;
  Color get onError;
  Color get errorContainer;
  Color get onErrorContainer;

  Color get surfaceDim;
  Color get surface;
  Color get surfaceBright;
  Color get inverseSurface;
  Color get onInverseSurface;
  Color get surfaceContainerLowest;
  Color get surfaceContainerLow;
  Color get surfaceContainer;
  Color get surfaceContainerHigh;
  Color get surfaceContainerHighest;
  Color get onSurface;
  Color get onSurfaceVariant;
  Color get outline;
  Color get outlineVariant;
  Color get scrim;
  Color get shadow;
  Color get inversePrimary;

  /// Custom - App
  Color get success;
  Color get info;
  Color get warning;
  Color get appleLogo;
  Color get googleLogo;
  Color get facebookLogo;
}
