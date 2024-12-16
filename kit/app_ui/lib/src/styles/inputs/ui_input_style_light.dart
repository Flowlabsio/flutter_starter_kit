import 'package:app_ui/src/colors/colors.dart';
import 'package:app_ui/src/styles/inputs/ui_input_style.dart';
import 'package:app_ui/src/ui_spacing.dart';
import 'package:flutter/material.dart';

class UIInputStyleLight implements UIInputStyle {
  UIInputStyleLight._singleton();

  static final UIInputStyleLight instance = UIInputStyleLight._singleton();

  UIColor uiColor = UIColorLight.instance;

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
