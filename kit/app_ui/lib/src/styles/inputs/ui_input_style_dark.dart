import 'package:app_ui/src/colors/colors.dart';
import 'package:app_ui/src/styles/inputs/ui_input_style.dart';
import 'package:app_ui/src/ui_spacing.dart';
import 'package:flutter/material.dart';

class UIInputStyleDark implements UIInputStyle {
  UIInputStyleDark._singleton();

  static final UIInputStyleDark instance = UIInputStyleDark._singleton();

  UIColor uiColor = UIColorDark.instance;

  @override
  InputDecoration get primary => InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: uiColor.onSurfaceVariant),
          borderRadius: BorderRadius.circular(UISpacing.space3x),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: uiColor.primary),
          borderRadius: BorderRadius.circular(UISpacing.space3x),
        ),
      );
}
