import 'dart:async';
import 'package:app_initial/app_initial.dart';

class Session {
  Session._singleton();

  static final Session instance = Session._singleton();

  final _streamController = StreamController<Session>.broadcast();

  Stream<Session> get stream => _streamController.stream;

  final _isPublicOnboardCompletedKey = 'isPublicOnboardingCompletedKey';

  bool isPublicOnboardCompleted = false;

  Future<void> initialize() async {
    await Future.wait([
      _isPublicOnboardCompletedInit(),
    ]);
  }

  Future<void> _isPublicOnboardCompletedInit() async {
    isPublicOnboardCompleted =
        await Storage.instance.get<bool>(_isPublicOnboardCompletedKey) ?? false;
  }

  Future<void> setIsOnboardingCompleted({
    required bool isPublicOnboardCompleted,
  }) async {
    this.isPublicOnboardCompleted = isPublicOnboardCompleted;
    await Storage.instance
        .set(_isPublicOnboardCompletedKey, isPublicOnboardCompleted);
  }

  Future<void> removeSession() async {
    isPublicOnboardCompleted = false;
    await Storage.instance.remove(_isPublicOnboardCompletedKey);
  }

  Future<void> dispose() async {
    await _streamController.close();
  }
}
