import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:app_ui/app_ui.dart';

enum CustomSnackbarStatus {
  info,
  success,
  error,
  warning,
}

class CustomSnackbar {
  CustomSnackbar._singleton();

  static final CustomSnackbar _instance = CustomSnackbar._singleton();

  factory CustomSnackbar() {
    return _instance;
  }

  bool isSnackbarActive = false;

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    SnackBar snackBar,
  ) {
    hideSnackBar();

    final currentState = AppKeys().scaffoldMessengerKey.currentState;

    return currentState!.showSnackBar(snackBar);
  }

  void hideSnackBar() {
    final currentState = AppKeys().scaffoldMessengerKey.currentState;

    if (currentState == null) return;

    currentState.hideCurrentSnackBar();
  }

  void success({
    required String text,
    bool showIcon = true,
    bool showCloseButton = true,
    bool force = false,
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
    show(
      text: text,
      status: CustomSnackbarStatus.success,
      showIcon: showIcon,
      showCloseButton: showCloseButton,
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

  void info({
    required String text,
    bool showIcon = true,
    bool showCloseButton = true,
    bool force = false,
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
    show(
      text: text,
      status: CustomSnackbarStatus.info,
      showIcon: showIcon,
      showCloseButton: showCloseButton,
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
    required String text,
    bool showIcon = true,
    bool showCloseButton = true,
    bool force = false,
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
    show(
      text: text,
      status: CustomSnackbarStatus.error,
      showIcon: showIcon,
      showCloseButton: showCloseButton,
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

  void warning({
    required String text,
    bool showIcon = true,
    bool showCloseButton = true,
    bool force = false,
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
    show(
      text: text,
      status: CustomSnackbarStatus.warning,
      showIcon: showIcon,
      showCloseButton: showCloseButton,
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
    required String text,
    required CustomSnackbarStatus status,
    bool showIcon = true,
    bool showCloseButton = true,
    bool force = false,
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

    final context = AppKeys().getRootContext();

    final colorsProvider = Theme.of(context).colors;

    Color backgroundColor = colorsProvider.primary;

    if (status == CustomSnackbarStatus.error) {
      backgroundColor = colorsProvider.error;
    }

    if (status == CustomSnackbarStatus.warning) {
      backgroundColor = colorsProvider.warning;
    }

    if (status == CustomSnackbarStatus.info) {
      backgroundColor = colorsProvider.info;
    }

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
                    color: backgroundColor,
                    borderRadius: borderRadius ??
                        BorderRadius.circular(
                          UISpacing.space1x,
                        ),
                    boxShadow: boxShadow ??
                        [
                          BoxShadow(
                            color: UIColor.black.withOpacity(.3),
                            spreadRadius: UISpacing.px1,
                            blurRadius: UISpacing.space1x,
                            offset: const Offset(0, 2),
                          ),
                        ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          text,
                          style: textStyle ??
                              UITextStyle.bodySmall.copyWith(
                                color: colorsProvider.onPrimary,
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
