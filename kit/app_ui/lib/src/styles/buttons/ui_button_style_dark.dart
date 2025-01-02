import 'package:flutter/material.dart';
import 'package:app_ui/app_ui.dart';

class UIButtonStyleDark extends UIButtonStyle {
  UIButtonStyleDark._singleton();

  static final UIButtonStyleDark instance = UIButtonStyleDark._singleton();

  UIColor uiColor = UIColorDark.instance;
  UITextStyle uiTextStyle = UITextStyleDark.instance;

  @override
  ButtonStyle get primaryElevated {
    return ButtonStyle(
      minimumSize: WidgetStateProperty.all(
        const Size(UISpacing.zero, UISpacing.space12x),
      ),
      padding: WidgetStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(
          horizontal: UISpacing.space4x,
        ),
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UISpacing.space2x),
        ),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        uiTextStyle.labelLarge.copyWith(
          fontWeight: UIFontWeight.light,
        ),
      ),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return uiColor.onSurface;
        }
        return uiColor.primary;
      }),
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return uiColor.onSurface.withValues(alpha: 0.12);
          }
          return uiColor.surfaceContainerLow;
        },
      ),
      shadowColor: WidgetStateProperty.all<Color>(
        uiColor.shadow,
      ),
      elevation: WidgetStateProperty.all<double>(UISpacing.px1),
    );
  }

  @override
  ButtonStyle get primaryFilled {
    return ButtonStyle(
      minimumSize: WidgetStateProperty.all(
        const Size(UISpacing.zero, UISpacing.space12x),
      ),
      padding: WidgetStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(
          horizontal: UISpacing.space4x,
        ),
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UISpacing.space2x),
        ),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        uiTextStyle.labelLarge.copyWith(
          fontWeight: UIFontWeight.light,
        ),
      ),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return uiColor.onSurface.withValues(alpha: 0.50);
        }
        return uiColor.onPrimary;
      }),
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return uiColor.onSurface.withValues(alpha: 0.12);
          }
          return uiColor.primary;
        },
      ),
    );
  }

  @override
  ButtonStyle get primaryFilledTonal {
    return ButtonStyle(
      minimumSize: WidgetStateProperty.all(
        const Size(UISpacing.zero, UISpacing.space12x),
      ),
      padding: WidgetStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(
          horizontal: UISpacing.space4x,
        ),
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UISpacing.space2x),
        ),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        uiTextStyle.labelLarge.copyWith(
          fontWeight: UIFontWeight.light,
        ),
      ),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return uiColor.onSurface.withValues(alpha: 0.50);
        }
        return uiColor.onSecondaryContainer;
      }),
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return uiColor.onSurface.withValues(alpha: 0.12);
          }
          return uiColor.secondaryContainer;
        },
      ),
    );
  }

  @override
  ButtonStyle get primaryOutline {
    return ButtonStyle(
      minimumSize: WidgetStateProperty.all(
        const Size(UISpacing.zero, UISpacing.space12x),
      ),
      padding: WidgetStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(
          horizontal: UISpacing.space4x,
        ),
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UISpacing.space2x),
        ),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        uiTextStyle.labelLarge.copyWith(
          fontWeight: UIFontWeight.light,
        ),
      ),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return uiColor.outline;
        }
        return uiColor.primary;
      }),
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return UIColor.transparent;
          }
          return UIColor.transparent;
        },
      ),
      side: WidgetStateProperty.resolveWith<BorderSide>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return BorderSide(
              color: uiColor.onSurface.withValues(alpha: 0.12),
              width: UISpacing.px1,
            );
          }
          return BorderSide(
            color: uiColor.outline,
            width: UISpacing.px1,
          );
        },
      ),
    );
  }

  @override
  ButtonStyle get primaryText {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          return UIColor.transparent;
        },
      ),
      foregroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return uiColor.outline;
          }
          return uiColor.primary;
        },
      ),
      minimumSize: WidgetStateProperty.all(
        const Size(UISpacing.zero, UISpacing.space12x),
      ),
      padding: WidgetStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(
          horizontal: UISpacing.space4x,
        ),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(uiTextStyle.labelLarge),
      elevation: WidgetStateProperty.all(UISpacing.zero),
      splashFactory: InkRipple.splashFactory,
    );
  }
}
