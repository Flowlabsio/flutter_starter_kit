import 'package:flutter/foundation.dart';

enum LogLevel { debug, info, warning, error }

class AppLogger {
  static Future<void> log(
    String message, {
    required LogLevel level,
    StackTrace? stackTrace,
    Map<String, Object> metadata = const {},
  }) async {
    switch (level) {
      case LogLevel.debug:
      case LogLevel.info:
      case LogLevel.warning:
      case LogLevel.error:
    }

    if (kDebugMode) {
      print('${level.name.toUpperCase()}: $message');
      if (stackTrace != null) {
        print('$stackTrace');
      }

      if (level == LogLevel.error) {
        throw Exception(message);
      }
    }
  }

  static void debug(
    String message, {
    StackTrace? stackTrace,
    Map<String, Object> metadata = const {},
  }) =>
      log(
        message,
        level: LogLevel.debug,
        stackTrace: stackTrace,
        metadata: metadata,
      );

  static void info(
    String message, {
    StackTrace? stackTrace,
    Map<String, Object> metadata = const {},
  }) =>
      log(
        message,
        level: LogLevel.info,
        stackTrace: stackTrace,
        metadata: metadata,
      );

  static void warning(
    String message, {
    StackTrace? stackTrace,
    Map<String, Object> metadata = const {},
  }) =>
      log(
        message,
        level: LogLevel.warning,
        stackTrace: stackTrace,
        metadata: metadata,
      );

  static void error(
    String message, {
    StackTrace? stackTrace,
    Map<String, Object> metadata = const {},
  }) =>
      log(
        message,
        level: LogLevel.error,
        stackTrace: stackTrace,
        metadata: metadata,
      );
}
