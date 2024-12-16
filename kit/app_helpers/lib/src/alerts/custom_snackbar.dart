import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:app_ui/app_ui.dart';

class CustomSnackbar {
  CustomSnackbar._singleton();

  static final CustomSnackbar instance = CustomSnackbar._singleton();

  bool isSnackbarActive = false;

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    SnackBar snackBar,
  ) {
    hideSnackBar();

    final currentState = AppKeys.instance.scaffoldMessengerKey.currentState;

    return currentState!.showSnackBar(snackBar);
  }

  void hideSnackBar() {
    final currentState = AppKeys.instance.scaffoldMessengerKey.currentState;

    if (currentState == null) return;

    currentState.hideCurrentSnackBar();
  }

  void info({
    bool showIcon = true,
    bool showCloseButton = true,
    bool force = true,
    String? text,
    Color? backgroundColor,
    Color? textColor,
    Widget? content,
    Widget? icon,
    Duration? duration,
    TextStyle? textStyle,
    EdgeInsets? padding,
    EdgeInsets? contentPadding,
    List<BoxShadow>? boxShadow,
    BorderRadius? borderRadius,
    void Function()? onTap,
  }) {
    final context = AppKeys.instance.getRootContext();

    final colorsProvider = Theme.of(context).colors;

    show(
      showIcon: showIcon,
      showCloseButton: showCloseButton,
      force: force,
      text: text,
      backgroundColor: colorsProvider.primary,
      textColor: textColor,
      content: content,
      icon: icon,
      duration: duration,
      textStyle: textStyle,
      padding: padding,
      contentPadding: contentPadding,
      boxShadow: boxShadow,
      borderRadius: borderRadius,
      onTap: onTap,
    );
  }

  void error({
    bool showIcon = true,
    bool showCloseButton = true,
    bool force = true,
    String? text,
    Color? backgroundColor,
    Color? textColor,
    Widget? content,
    Widget? icon,
    Duration? duration,
    TextStyle? textStyle,
    EdgeInsets? padding,
    EdgeInsets? contentPadding,
    List<BoxShadow>? boxShadow,
    BorderRadius? borderRadius,
    void Function()? onTap,
  }) {
    final context = AppKeys.instance.getRootContext();

    final colorsProvider = Theme.of(context).colors;

    show(
      showIcon: showIcon,
      showCloseButton: showCloseButton,
      force: force,
      text: text,
      backgroundColor: colorsProvider.error,
      textColor: textColor,
      content: content,
      icon: icon,
      duration: duration,
      textStyle: textStyle,
      padding: padding,
      contentPadding: contentPadding,
      boxShadow: boxShadow,
      borderRadius: borderRadius,
      onTap: onTap,
    );
  }

  void show({
    bool showIcon = true,
    bool showCloseButton = true,
    bool force = true,
    String? text,
    Color? backgroundColor,
    Color? textColor,
    Widget? content,
    Widget? icon,
    Duration? duration,
    TextStyle? textStyle,
    EdgeInsets? padding,
    EdgeInsets? contentPadding,
    List<BoxShadow>? boxShadow,
    BorderRadius? borderRadius,
    void Function()? onTap,
  }) {
    if (!force) {
      if (isSnackbarActive) return;
    }

    isSnackbarActive = true;

    final context = AppKeys.instance.getRootContext();

    final colorsProvider = Theme.of(context).colors;
    final textStylesProvider = Theme.of(context).textStyles;

    Color bgColor = backgroundColor ?? colorsProvider.primary;

    showSnackBar(
      SnackBar(
        backgroundColor: UIColor.transparent,
        elevation: UISpacing.zero,
        padding: EdgeInsets.zero,
        duration: duration ?? const Duration(seconds: 5),
        content: GestureDetector(
          onTap: onTap,
          child: content ??
              Padding(
                padding: padding ??
                    const EdgeInsets.symmetric(
                      horizontal: UISpacing.space4x,
                      vertical: UISpacing.space4x,
                    ),
                child: Container(
                  padding: contentPadding ??
                      const EdgeInsets.only(
                        left: UISpacing.space4x,
                        right: UISpacing.space4x,
                        top: UISpacing.space4x,
                        bottom: UISpacing.space4x,
                      ),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: borderRadius ??
                        BorderRadius.circular(
                          UISpacing.space1x,
                        ),
                    boxShadow: boxShadow ??
                        [
                          BoxShadow(
                            color: colorsProvider.shadow.withValues(alpha: 0.3),
                            spreadRadius: UISpacing.px1,
                            blurRadius: UISpacing.space1x,
                            offset: const Offset(0, 2),
                          ),
                        ],
                  ),
                  child: Row(
                    children: [
                      if (text != null)
                        Expanded(
                          child: Text(
                            text,
                            style: textStyle ??
                                textStylesProvider.bodySmall.copyWith(
                                  color: textColor ?? colorsProvider.onPrimary,
                                ),
                          ),
                        ),
                      if (showCloseButton)
                        SizedBox(
                          width: UISpacing.space5x,
                          height: UISpacing.space5x,
                          child: IconButton(
                            onPressed: hideSnackBar,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: Icon(
                              Icons.close,
                              color: colorsProvider.onPrimary,
                              size: UISpacing.space2x + UISpacing.px2,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
        ),
      ),
    ).closed.then((SnackBarClosedReason reason) {
      isSnackbarActive = false;
    });
  }
}
