import 'package:flutter/material.dart';

class AppKeys {
  AppKeys._singleton();

  static final AppKeys instance = AppKeys._singleton();

  GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  BuildContext getRootContext() {
    return rootNavigatorKey.currentContext!;
  }
}
