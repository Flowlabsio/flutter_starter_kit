import 'package:flutter/material.dart';
import 'package:app_ui/app_ui.dart';

class UIButtonStyleDark extends UIButtonStyle {
  UIButtonStyleDark._singleton();

  static final UIButtonStyleDark _instance = UIButtonStyleDark._singleton();

  factory UIButtonStyleDark() {
    return _instance;
  }

  UIColor uiColor = UIColorDark();

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
