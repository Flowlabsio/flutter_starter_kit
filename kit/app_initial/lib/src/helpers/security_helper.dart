import 'package:app_initial/src/facades/facades.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class SecurityHelper {
  SecurityHelper._singleton();

  static final SecurityHelper instance = SecurityHelper._singleton();

  final auth = LocalAuthentication();

  Future<void> checkLastUnlock() async {
    if (!Security.instance.isSafeActive) return;
    if (!Security.instance.wasUnlocked) return;

    final lastUnlockAt = Security.instance.lastUnlockAt;

    if (lastUnlockAt == null) {
      await Security.instance.setSecurity(
        wasUnlocked: false,
      );
      return;
    }

    final frequencyLocked = Security.instance.frequencyLocked;

    final limitTime = lastUnlockAt.add(Duration(seconds: frequencyLocked!));

    if (DateTime.now().isAfter(limitTime)) {
      await Security.instance.setSecurity(
        wasUnlocked: false,
      );
    }
  }

  Future<bool> unlockSupported() {
    return auth.isDeviceSupported();
  }

  Future<bool> biometricSupported() async {
    return auth.canCheckBiometrics;
  }

  Future<bool> authenticate({
    required String localizedReason,
    bool? biometricOnly,
    bool useErrorDialogs = true,
  }) async {
    try {
      return await auth.authenticate(
        localizedReason: localizedReason,
        options: AuthenticationOptions(
          biometricOnly: biometricOnly ?? await biometricSupported(),
          useErrorDialogs: useErrorDialogs,
        ),
      );
    } catch (e) {
      if (e is PlatformException) {
        if (e.code == 'NotAvailable') {
          return false;
        }
      }
      rethrow;
    }
  }
}
