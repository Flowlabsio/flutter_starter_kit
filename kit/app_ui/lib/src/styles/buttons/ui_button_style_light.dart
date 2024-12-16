import 'package:flutter/material.dart';
import 'package:app_ui/app_ui.dart';

class UIButtonStyleLight extends UIButtonStyle {
  UIButtonStyleLight._singleton();

  static final UIButtonStyleLight _instance = UIButtonStyleLight._singleton();

  factory UIButtonStyleLight() {
    return _instance;
  }

  UIColor uiColor = UIColorLight();

  @override
  ButtonStyle get primaryFilled {
    return super.primaryFilled.copyWith(
          foregroundColor: WidgetStateProperty.all<Color>(
            uiColor.onPrimary,
          ),
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return uiColor.primary;
              }
              if (states.contains(WidgetState.pressed)) {
                return uiColor.primary;
              }
              if (states.contains(WidgetState.hovered)) {
                return uiColor.primary;
              }
              return uiColor.primary;
            },
          ),
        );
  }

  @override
  ButtonStyle get primaryOutline {
    return super.primaryFilled.copyWith(
          foregroundColor: WidgetStateProperty.all<Color>(
            uiColor.primary,
          ),
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return UIColor.transparent;
              }
              if (states.contains(WidgetState.pressed)) {
                return UIColor.transparent;
              }
              if (states.contains(WidgetState.hovered)) {
                return UIColor.transparent;
              }
              return UIColor.transparent;
            },
          ),
          side: WidgetStateProperty.resolveWith<BorderSide>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return BorderSide(color: uiColor.outline, width: UISpacing.px1);
              }
              if (states.contains(WidgetState.pressed)) {
                return BorderSide(color: uiColor.outline, width: UISpacing.px1);
              }
              if (states.contains(WidgetState.hovered)) {
                return BorderSide(color: uiColor.outline, width: UISpacing.px1);
              }
              return BorderSide(color: uiColor.outline, width: UISpacing.px1);
            },
          ),
        );
  }
}
