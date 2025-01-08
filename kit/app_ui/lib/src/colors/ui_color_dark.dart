import 'package:app_ui/src/src.dart';
import 'package:flutter/material.dart';

class UIColorDark extends UIColor {
  UIColorDark._singleton();

  static final UIColorDark instance = UIColorDark._singleton();

  @override
  Color get primary => primarySchema[80]!;

  @override
  Color get onPrimary => primarySchema[20]!;

  @override
  Color get primaryContainer => primarySchema[30]!;

  @override
  Color get onPrimaryContainer => primarySchema[90]!;

  @override
  Color get primaryFixed => primarySchema[90]!;

  @override
  Color get primaryFixedDim => primarySchema[80]!;

  @override
  Color get onPrimaryFixed => primarySchema[10]!;

  @override
  Color get onPrimaryFixedVariant => primarySchema[30]!;

  @override
  Color get secondary => secondarySchema[80]!;

  @override
  Color get onSecondary => secondarySchema[20]!;

  @override
  Color get secondaryContainer => secondarySchema[30]!;

  @override
  Color get onSecondaryContainer => secondarySchema[90]!;

  @override
  Color get secondaryFixed => secondarySchema[90]!;

  @override
  Color get secondaryFixedDim => secondarySchema[80]!;

  @override
  Color get onSecondaryFixed => secondarySchema[10]!;

  @override
  Color get onSecondaryFixedVariant => secondarySchema[30]!;

  @override
  Color get tertiary => tertiarySchema[80]!;

  @override
  Color get onTertiary => tertiarySchema[20]!;

  @override
  Color get tertiaryContainer => tertiarySchema[30]!;

  @override
  Color get onTertiaryContainer => tertiarySchema[90]!;

  @override
  Color get tertiaryFixed => tertiarySchema[90]!;

  @override
  Color get tertiaryFixedDim => tertiarySchema[80]!;

  @override
  Color get onTertiaryFixed => tertiarySchema[10]!;

  @override
  Color get onTertiaryFixedVariant => tertiarySchema[30]!;

  @override
  Color get error => errorSchema[80]!;

  @override
  Color get onError => errorSchema[20]!;

  @override
  Color get errorContainer => errorSchema[30]!;

  @override
  Color get onErrorContainer => errorSchema[90]!;

  @override
  Color get surfaceDim => neutralSchema[12]!;

  @override
  Color get surface => neutralSchema[16]!;

  @override
  Color get surfaceBright => neutralSchema[24]!;

  @override
  Color get inverseSurface => neutralSchema[90]!;

  @override
  Color get onInverseSurface => neutralSchema[20]!;

  @override
  Color get surfaceContainerLowest => neutralSchema[4]!;

  @override
  Color get surfaceContainerLow => neutralSchema[10]!;

  @override
  Color get surfaceContainer => neutralSchema[12]!;

  @override
  Color get surfaceContainerHigh => neutralSchema[17]!;

  @override
  Color get surfaceContainerHighest => neutralSchema[22]!;

  @override
  Color get onSurface => neutralSchema[90]!;

  @override
  Color get onSurfaceVariant => neutralVariantSchema[80]!;

  @override
  Color get outline => neutralVariantSchema[60]!;

  @override
  Color get outlineVariant => neutralVariantSchema[30]!;

  @override
  Color get scrim => neutralSchema[0]!;

  @override
  Color get shadow => neutralSchema[0]!;

  @override
  Color get inversePrimary => primarySchema[40]!;

  /// Custom - App
  @override
  Color get success => const Color(0xFF2A5C40);

  @override
  Color get info => const Color(0xFF2A6FB8);

  @override
  Color get warning => const Color(0xFFC78A31);

  @override
  Color get appleLogo => const Color(0xFF444444);

  @override
  Color get googleLogo => const Color(0xFF4285F4);

  @override
  Color get facebookLogo => const Color(0xFF1877F2);
}
