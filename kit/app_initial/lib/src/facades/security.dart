import 'dart:async';

import 'package:app_initial/src/facades/facades.dart';
import 'package:app_initial/src/helpers/helpers.dart';

class Security {
  Security._singleton();

  static final instance = Security._singleton();

  final _streamController = StreamController<Security>.broadcast();

  Stream<Security> get stream => _streamController.stream;

  final _lastUnlockAtKey = 'lastUnlockAtKey';
  final _frequencyLockedKey = 'frequencyLockedKey';

  DateTime? lastUnlockAt;
  int? frequencyLocked;
  bool wasUnlocked = false;
  bool isPaused = false;

  Future<void> initialize() async {
    await Future.wait([
      _init(),
    ]);
  }

  Future<void> _init() async {
    final frequencyUnlockString =
        await Storage.instance.get<int>(_frequencyLockedKey);

    frequencyLocked = frequencyUnlockString;

    final lastUnlockedAtRaw =
        await Storage.instance.get<String>(_lastUnlockAtKey);

    lastUnlockAt =
        lastUnlockedAtRaw != null ? DateTime.parse(lastUnlockedAtRaw) : null;
  }

  Future<void> setSecurity({
    Parameter<int?>? frequencyLocked,
    DateTime? lastUnlockAt,
    bool? wasUnlocked,
  }) async {
    if (frequencyLocked != null) {
      this.frequencyLocked = frequencyLocked.value;

      if (frequencyLocked.value == null) {
        await Storage.instance.remove(_frequencyLockedKey);
      } else {
        await Storage.instance.set(
          _frequencyLockedKey,
          frequencyLocked.value!,
        );
      }
    }

    if (lastUnlockAt != null) {
      this.lastUnlockAt = lastUnlockAt;

      await Storage.instance.set(
        _lastUnlockAtKey,
        lastUnlockAt.toIso8601String(),
      );
    }

    if (wasUnlocked != null) {
      this.wasUnlocked = wasUnlocked;
    }

    _streamController.add(this);
  }

  Future<void> removeSecurity() async {
    lastUnlockAt = null;
    frequencyLocked = null;
    wasUnlocked = false;

    await Storage.instance.remove(_lastUnlockAtKey);
    await Storage.instance.remove(_frequencyLockedKey);

    _streamController.add(this);
  }

  bool get isSafeActive => frequencyLocked != null;

  bool get isRequiredCheckBiometric {
    if (isPaused) return false;

    if (frequencyLocked == null) return false;

    if (wasUnlocked) return false;

    if (lastUnlockAt == null) return true;

    final now = DateTime.now();
    final difference = now.difference(lastUnlockAt!);

    return difference.inSeconds >= frequencyLocked!;
  }

  Future<void> dispose() async {
    await _streamController.close();
  }
}
