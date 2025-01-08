import 'package:app_ui/src/src.dart';
import 'package:flutter/material.dart';

class UIColorLight extends UIColor {
  UIColorLight._singleton();

  static final UIColorLight instance = UIColorLight._singleton();

  @override
  Color get primary => primarySchema[40]!;

  @override
  Color get onPrimary => primarySchema[100]!;

  @override
  Color get primaryContainer => primarySchema[90]!;

  @override
  Color get onPrimaryContainer => primarySchema[30]!;

  @override
  Color get primaryFixed => primarySchema[90]!;

  @override
  Color get primaryFixedDim => primarySchema[80]!;

  @override
  Color get onPrimaryFixed => primarySchema[10]!;

  @override
  Color get onPrimaryFixedVariant => primarySchema[30]!;

  @override
  Color get secondary => secondarySchema[40]!;

  @override
  Color get onSecondary => secondarySchema[100]!;

  @override
  Color get secondaryContainer => secondarySchema[90]!;

  @override
  Color get onSecondaryContainer => secondarySchema[30]!;

  @override
  Color get secondaryFixed => secondarySchema[90]!;

  @override
  Color get secondaryFixedDim => secondarySchema[80]!;

  @override
  Color get onSecondaryFixed => secondarySchema[10]!;

  @override
  Color get onSecondaryFixedVariant => secondarySchema[30]!;

  @override
  Color get tertiary => tertiarySchema[40]!;

  @override
  Color get onTertiary => tertiarySchema[100]!;

  @override
  Color get tertiaryContainer => tertiarySchema[90]!;

  @override
  Color get onTertiaryContainer => tertiarySchema[30]!;

  @override
  Color get tertiaryFixed => tertiarySchema[90]!;

  @override
  Color get tertiaryFixedDim => tertiarySchema[80]!;

  @override
  Color get onTertiaryFixed => tertiarySchema[10]!;

  @override
  Color get onTertiaryFixedVariant => tertiarySchema[30]!;

  @override
  Color get error => errorSchema[40]!;

  @override
  Color get onError => errorSchema[100]!;

  @override
  Color get errorContainer => errorSchema[90]!;

  @override
  Color get onErrorContainer => errorSchema[30]!;

  @override
  Color get surfaceDim => neutralSchema[87]!;

  @override
  Color get surface => neutralSchema[98]!;

  @override
  Color get surfaceBright => neutralSchema[98]!;

  @override
  Color get inverseSurface => neutralSchema[20]!;

  @override
  Color get onInverseSurface => neutralSchema[95]!;

  @override
  Color get surfaceContainerLowest => neutralSchema[100]!;

  @override
  Color get surfaceContainerLow => neutralSchema[96]!;

  @override
  Color get surfaceContainer => neutralSchema[94]!;

  @override
  Color get surfaceContainerHigh => neutralSchema[92]!;

  @override
  Color get surfaceContainerHighest => neutralSchema[90]!;

  @override
  Color get onSurface => neutralSchema[10]!;

  @override
  Color get onSurfaceVariant => neutralVariantSchema[30]!;

  @override
  Color get outline => neutralVariantSchema[50]!;

  @override
  Color get outlineVariant => neutralVariantSchema[80]!;

  @override
  Color get scrim => neutralSchema[0]!;

  @override
  Color get shadow => neutralSchema[0]!;

  @override
  Color get inversePrimary => primarySchema[80]!;

  /// Custom - App
  @override
  Color get success => const Color(0xFF3C885A);

  @override
  Color get info => const Color(0xFF3B9FF0);

  @override
  Color get warning => const Color(0xFFEEAB46);

  @override
  Color get appleLogo => const Color(0xFF000000);

  @override
  Color get googleLogo => const Color(0xFF4285F4);

  @override
  Color get facebookLogo => const Color(0xFF1877F2);
}
