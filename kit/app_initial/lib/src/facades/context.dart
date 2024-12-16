import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

class Context {
  Context._singleton();

  static final Context instance = Context._singleton();

  final appKeys = AppKeys.instance;

  T of<T>(T Function(BuildContext context) callback) {
    return callback(appKeys.getRootContext());
  }
}
