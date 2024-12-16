import 'package:flutter/material.dart';
import 'package:app_ui/app_ui.dart';

abstract class UIButtonStyle {
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
        UITextStyle.bodyLarge.copyWith(
          fontWeight: UIFontWeight.light,
        ),
      ),
    );
  }

  ButtonStyle get primaryOutline;
}
