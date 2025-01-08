import 'dart:ui';

class EventHook {
  EventHook(this.state, this.time);

  final AppLifecycleState state;
  final DateTime time;

  @override
  String toString() {
    return 'State: $state, Time: $time';
  }
}
