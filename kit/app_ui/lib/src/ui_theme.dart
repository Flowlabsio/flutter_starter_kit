import 'package:app_ui/src/src.dart';
import 'package:flutter/material.dart';

class UITheme {
  static ThemeData get dark {
    final uiColors = UIColorDark();

    return ThemeData(
      colorScheme: colorSchemeDark,
      textTheme: textTheme.apply(
        bodyColor: uiColors.onSurface,
        displayColor: uiColors.onSurface,
        decorationColor: uiColors.onSurface,
      ),
    );
  }

  static ThemeData get light {
    final uiColors = UIColorLight();

    return _standard.copyWith(
      colorScheme: colorSchemeLight,
      textTheme: textTheme.apply(
        bodyColor: uiColors.onSurface,
        displayColor: uiColors.onSurface,
        decorationColor: uiColors.onSurface,
      ),
    );
  }

  static ThemeData get _standard {
    return ThemeData(
      appBarTheme: appBarTheme,
      useMaterial3: true,
    );
  }

  static AppBarTheme get appBarTheme {
    return const AppBarTheme(
      scrolledUnderElevation: 0,
      elevation: 0,
    );
  }

  static TextTheme get textTheme {
    return TextTheme(
      displayLarge: UITextStyle.displayLarge,
      displayMedium: UITextStyle.displayMedium,
      displaySmall: UITextStyle.displaySmall,
      headlineLarge: UITextStyle.headlineLarge,
      headlineMedium: UITextStyle.headlineMedium,
      headlineSmall: UITextStyle.headlineSmall,
      titleLarge: UITextStyle.titleLarge,
      titleMedium: UITextStyle.titleMedium,
      titleSmall: UITextStyle.titleSmall,
      bodyLarge: UITextStyle.bodyLarge,
      bodyMedium: UITextStyle.bodyMedium,
      bodySmall: UITextStyle.bodySmall,
      labelLarge: UITextStyle.labelLarge,
      labelMedium: UITextStyle.labelMedium,
      labelSmall: UITextStyle.labelSmall,
    );
  }

  static ColorScheme get colorSchemeLight {
    final uiColors = UIColorLight();

    return ColorScheme(
      brightness: Brightness.light,
      primary: uiColors.primary,
      onPrimary: uiColors.onPrimary,
      primaryContainer: uiColors.primaryContainer,
      onPrimaryContainer: uiColors.onPrimaryContainer,
      primaryFixed: uiColors.primaryFixed,
      primaryFixedDim: uiColors.primaryFixedDim,
      onPrimaryFixed: uiColors.onPrimaryFixed,
      onPrimaryFixedVariant: uiColors.onPrimaryFixedVariant,
      secondary: uiColors.secondary,
      onSecondary: uiColors.onSecondary,
      secondaryContainer: uiColors.secondaryContainer,
      onSecondaryContainer: uiColors.onSecondaryContainer,
      secondaryFixed: uiColors.secondaryFixed,
      secondaryFixedDim: uiColors.secondaryFixedDim,
      onSecondaryFixed: uiColors.onSecondaryFixed,
      onSecondaryFixedVariant: uiColors.onSecondaryFixedVariant,
      tertiary: uiColors.tertiary,
      onTertiary: uiColors.onTertiary,
      tertiaryContainer: uiColors.tertiaryContainer,
      onTertiaryContainer: uiColors.onTertiaryContainer,
      tertiaryFixed: uiColors.tertiaryFixed,
      tertiaryFixedDim: uiColors.tertiaryFixedDim,
      onTertiaryFixed: uiColors.onTertiaryFixed,
      onTertiaryFixedVariant: uiColors.onTertiaryFixedVariant,
      error: uiColors.error,
      onError: uiColors.onError,
      errorContainer: uiColors.errorContainer,
      onErrorContainer: uiColors.onErrorContainer,
      surfaceDim: uiColors.surfaceDim,
      surface: uiColors.surface,
      surfaceBright: uiColors.surfaceBright,
      inverseSurface: uiColors.inverseSurface,
      onInverseSurface: uiColors.onInverseSurface,
      surfaceContainerLowest: uiColors.surfaceContainerLowest,
      surfaceContainerLow: uiColors.surfaceContainerLow,
      surfaceContainer: uiColors.surfaceContainer,
      surfaceContainerHigh: uiColors.surfaceContainerHigh,
      surfaceContainerHighest: uiColors.surfaceContainerHighest,
      onSurface: uiColors.onSurface,
      onSurfaceVariant: uiColors.onSurfaceVariant,
      outline: uiColors.outline,
      outlineVariant: uiColors.outlineVariant,
      scrim: uiColors.scrim,
      shadow: uiColors.shadow,
      inversePrimary: uiColors.inversePrimary,
    );
  }

  static ColorScheme get colorSchemeDark {
    final uiColors = UIColorDark();

    return ColorScheme(
      brightness: Brightness.dark,
      primary: uiColors.primary,
      onPrimary: uiColors.onPrimary,
      primaryContainer: uiColors.primaryContainer,
      onPrimaryContainer: uiColors.onPrimaryContainer,
      primaryFixed: uiColors.primaryFixed,
      primaryFixedDim: uiColors.primaryFixedDim,
      onPrimaryFixed: uiColors.onPrimaryFixed,
      onPrimaryFixedVariant: uiColors.onPrimaryFixedVariant,
      secondary: uiColors.secondary,
      onSecondary: uiColors.onSecondary,
      secondaryContainer: uiColors.secondaryContainer,
      onSecondaryContainer: uiColors.onSecondaryContainer,
      secondaryFixed: uiColors.secondaryFixed,
      secondaryFixedDim: uiColors.secondaryFixedDim,
      onSecondaryFixed: uiColors.onSecondaryFixed,
      onSecondaryFixedVariant: uiColors.onSecondaryFixedVariant,
      tertiary: uiColors.tertiary,
      onTertiary: uiColors.onTertiary,
      tertiaryContainer: uiColors.tertiaryContainer,
      onTertiaryContainer: uiColors.onTertiaryContainer,
      tertiaryFixed: uiColors.tertiaryFixed,
      tertiaryFixedDim: uiColors.tertiaryFixedDim,
      onTertiaryFixed: uiColors.onTertiaryFixed,
      onTertiaryFixedVariant: uiColors.onTertiaryFixedVariant,
      error: uiColors.error,
      onError: uiColors.onError,
      errorContainer: uiColors.errorContainer,
      onErrorContainer: uiColors.onErrorContainer,
      surfaceDim: uiColors.surfaceDim,
      surface: uiColors.surface,
      surfaceBright: uiColors.surfaceBright,
      inverseSurface: uiColors.inverseSurface,
      onInverseSurface: uiColors.onInverseSurface,
      surfaceContainerLowest: uiColors.surfaceContainerLowest,
      surfaceContainerLow: uiColors.surfaceContainerLow,
      surfaceContainer: uiColors.surfaceContainer,
      surfaceContainerHigh: uiColors.surfaceContainerHigh,
      surfaceContainerHighest: uiColors.surfaceContainerHighest,
      onSurface: uiColors.onSurface,
      onSurfaceVariant: uiColors.onSurfaceVariant,
      outline: uiColors.outline,
      outlineVariant: uiColors.outlineVariant,
      scrim: uiColors.scrim,
      shadow: uiColors.shadow,
      inversePrimary: uiColors.inversePrimary,
    );
  }
}
