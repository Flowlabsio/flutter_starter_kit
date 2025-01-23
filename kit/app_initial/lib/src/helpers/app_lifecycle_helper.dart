import 'dart:async';

import 'package:app_initial/src/facades/facades.dart';
import 'package:app_initial/src/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AppLifecycleHelper {
  AppLifecycleHelper._singleton();

  static final instance = AppLifecycleHelper._singleton();

  Future<void> initialize() async {
    final firstEvent = SchedulerBinding.instance.lifecycleState;

    if (firstEvent != null) {
      addLifecycleEvent(firstEvent);
    }

    _listener = AppLifecycleListener(
      onShow: onShow,
      onResume: onResume,
      onHide: onHide,
      onInactive: onInactive,
      onPause: onPause,
      onDetach: onDetach,
      onRestart: onRestart,
      onStateChange: onStateChange,
    );
  }

  late final AppLifecycleListener _listener;

  final List<EventHook> lifecycleEvents = [];

  void onStateChange(AppLifecycleState state) {
    addLifecycleEvent(state);
  }

  void addLifecycleEvent(AppLifecycleState state) {
    final event = EventHook(state, DateTime.now());

    lifecycleEvents.add(event);

    if (lifecycleEvents.length > 20) {
      lifecycleEvents.removeAt(0);
    }
  }

  EventHook get previousEvent {
    return lifecycleEvents.last;
  }

  Future<void> onShow() async {}

  Future<void> onResume() async {}

  Future<void> onHide() async {}

  Future<void> onInactive() async {}

  Future<void> onPause() async {}

  Future<void> onDetach() async {
    await Auth.instance.dispose();
    await Preference.instance.dispose();
    await Security.instance.dispose();
    await Session.instance.dispose();

    userUpdateNotifier.dispose();
  }

  Future<void> onRestart() async {
    unawaited(ConnectivityHelper.instance.analyzeConnection());

    await SecurityHelper.instance.checkLastUnlock();
  }

  Future<void> dispose() async {
    _listener.dispose();
  }
}
