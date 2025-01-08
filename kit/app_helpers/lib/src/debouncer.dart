import 'dart:async';

import 'package:flutter/widgets.dart';

class Debouncer {
  Debouncer({required this.duration});

  final Duration duration;
  Timer? _timer;

  void run(VoidCallback action, {bool executeImmediately = false}) {
    if (executeImmediately && (_timer == null || !_timer!.isActive)) {
      action();
    }
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(duration, action);
  }

  void cancel() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  void reset() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = Timer(duration, () {});
    }
  }

  void dispose() {
    cancel();
  }
}
