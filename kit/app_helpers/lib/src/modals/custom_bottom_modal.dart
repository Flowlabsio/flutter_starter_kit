import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class CustomBottomModal {
  CustomBottomModal._singleton();

  static final CustomBottomModal instance = CustomBottomModal._singleton();

  Future<T?> show<T>(
    Widget child, {
    bool useFullHeight = false,
    bool useSafeArea = true,
    bool isScrollControlled = false,
    BorderRadius borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(UISpacing.space4x),
      topRight: Radius.circular(UISpacing.space4x),
    ),
    bool isDismissible = true,
  }) {
    return showModalBottomSheet<T>(
      isDismissible: isDismissible,
      useSafeArea: useSafeArea,
      context: AppKeys.instance.getRootContext(),
      isScrollControlled: isScrollControlled || useFullHeight,
      builder: (BuildContext context) {
        final height = MediaQuery.of(context).size.height;

        return Container(
          height: useFullHeight ? height : null,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
          ),
          child: child,
        );
      },
    );
  }
}
