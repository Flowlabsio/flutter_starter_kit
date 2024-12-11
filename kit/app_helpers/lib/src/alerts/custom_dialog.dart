import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  CustomDialog._singleton();

  static final CustomDialog _instance = CustomDialog._singleton();

  factory CustomDialog() {
    return _instance;
  }

  Future<bool> confirm({
    BuildContext? buildContext,
    Widget? title,
    Widget? content,
    List<Widget>? actions,
    EdgeInsets? titlePadding,
    EdgeInsets? contentPadding,
    EdgeInsets? actionsPadding,
    Color? backgroundColor,
    Color? surfaceTintColor,
    Color? shadowColor,
    bool barrierDismissible = true,
  }) async {
    final value = await show(
      buildContext: buildContext,
      title: title,
      content: content,
      actions: actions,
      titlePadding: titlePadding,
      contentPadding: contentPadding,
      actionsPadding: actionsPadding,
      backgroundColor: backgroundColor,
      surfaceTintColor: surfaceTintColor,
      shadowColor: shadowColor,
      barrierDismissible: barrierDismissible,
    );

    return value != null && value == true;
  }

  Future<T?> show<T>({
    BuildContext? buildContext,
    Widget? title,
    Widget? content,
    List<Widget>? actions,
    EdgeInsets? titlePadding,
    EdgeInsets? contentPadding,
    EdgeInsets? actionsPadding,
    Color? backgroundColor,
    Color? surfaceTintColor,
    Color? shadowColor,
    bool barrierDismissible = true,
  }) async {
    final context = buildContext ?? AppKeys().getRootContext();

    final colorsProvider = Theme.of(context).colors;

    final value = await showDialog<T>(
      barrierColor: colorsProvider.inverseSurface.withOpacity(0.2),
      barrierDismissible: barrierDismissible,
      context: buildContext ?? AppKeys().getRootContext(),
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: title != null
              ? titlePadding ??
                  const EdgeInsets.symmetric(
                    horizontal: UISpacing.space6x,
                    vertical: UISpacing.space5x,
                  )
              : EdgeInsets.zero,
          contentPadding: content != null
              ? contentPadding ??
                  const EdgeInsets.symmetric(
                    horizontal: UISpacing.space6x,
                  )
              : EdgeInsets.zero,
          actionsPadding: actions != null
              ? actionsPadding ??
                  const EdgeInsets.symmetric(
                    horizontal: UISpacing.space6x,
                    vertical: UISpacing.space5x,
                  )
              : EdgeInsets.zero,
          title: title,
          content: content,
          actions: actions,
          backgroundColor: backgroundColor ?? colorsProvider.surface,
          surfaceTintColor: surfaceTintColor ?? colorsProvider.surfaceContainer,
          shadowColor: shadowColor ?? colorsProvider.shadow,
        );
      },
    );

    return value;
  }
}
