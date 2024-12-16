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
  ButtonStyle get primary {
    return super.primary.copyWith(
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
}
