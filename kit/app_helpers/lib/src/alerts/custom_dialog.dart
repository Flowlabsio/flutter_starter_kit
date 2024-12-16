import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  CustomDialog._singleton();

  static final CustomDialog instance = CustomDialog._singleton();

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
    return await showDialog<T>(
      barrierDismissible: barrierDismissible,
      context: buildContext ?? AppKeys.instance.getRootContext(),
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
          backgroundColor: backgroundColor,
          surfaceTintColor: surfaceTintColor,
          shadowColor: shadowColor,
        );
      },
    );
  }
}
