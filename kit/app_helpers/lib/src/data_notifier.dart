import 'dart:async';

class DataNotifier<R> {
  final _controller = StreamController<R>.broadcast();

  Stream<R> get stream => _controller.stream;

  void emit(R notify) {
    _controller.add(notify);
  }

  void dispose() {
    _controller.close();
  }
}

