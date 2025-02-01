import 'dart:convert';
import 'dart:io';

import 'package:app_helpers/app_helpers.dart';
import 'package:app_initial/src/datasources/auth/auth.dart';
import 'package:app_initial/src/datasources/device/device.dart';
import 'package:app_initial/src/datasources/user/user.dart';
import 'package:app_initial/src/helpers/helpers.dart';
import 'package:app_initial/src/models/models.dart';
import 'package:app_initial/src/repositories/auth/auth.dart';
import 'package:app_initial/src/repositories/device/device.dart';
import 'package:app_initial/src/repositories/user/user.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class CancelledByUserException implements Exception {}

class AuthHelper {
  AuthHelper._singleton();

  static final AuthHelper instance = AuthHelper._singleton();

  Future<AuthorizationCredentialAppleID> signInWithApple() async {
    try {
      return await SignInWithApple.getAppleIDCredential(
        webAuthenticationOptions: !Platform.isIOS
            ? WebAuthenticationOptions(
                clientId: Env.appleServiceId,
                redirectUri: Uri.parse(Env.appleRedirectUrl),
              )
            : null,
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
    } catch (e) {
      if (e is SignInWithAppleAuthorizationException &&
          e.code == AuthorizationErrorCode.canceled) {
        throw CancelledByUserException();
      }
      rethrow;
    }
  }

  Future<GoogleSignInAccount> signInWithGoogle() async {
    try {
      final googleSignInAccount = await GoogleSignIn(
        clientId: !Platform.isAndroid ? Env.googleClientId : null,
      ).signIn();

      if (googleSignInAccount == null) {
        throw CancelledByUserException();
      }

      return googleSignInAccount;
    } catch (e) {
      if (e is PlatformException && e.details == 'access_denied') {
        throw CancelledByUserException();
      }
      rethrow;
    }
  }

  Future<(LoginResult, String)> signInWithFacebook() async {
    final rawNonce = generateNonce();
    final bytes = utf8.encode(rawNonce);
    final digest = sha256.convert(bytes);

    final loginResult = await FacebookAuth.instance.login(
      nonce: digest.toString(),
    );

    if (loginResult.status == LoginStatus.cancelled) {
      throw CancelledByUserException();
    }

    return (loginResult, rawNonce);
  }

  Future<User> getUserByCredentials(
    UserCredential userCredential, {
    bool storeUserIfNotFound = true,
  }) async {
    final userRepository = UserRepositoryImpl(
      userDatasource: UserFirebaseDatasource(),
    );

    final deviceRepository = DeviceRepositoryImpl(
      deviceDatasource: DeviceFirebaseDatasource(),
    );

    User user;
    try {
      final result  = await userRepository.findById(
        userCredential.id,
      );

      user = result.getOrThrow();
    } on UserNotFound {
      if (!storeUserIfNotFound) {
        throw UserNotFound();
      }

      user = await userRepository.store(
        id: userCredential.id,
        firstName: userCredential.firstName ?? '',
        lastName: userCredential.lastName ?? '',
        email: userCredential.email ?? '',
      );
    }

    try {
      final deviceInfo = await DeviceInfoHelper().getInfo();

      try {
        await deviceRepository.findById(
          userId: user.id,
          id: deviceInfo.id,
        );

        await deviceRepository.update(
          userId: user.id,
          id: deviceInfo.id,
          lastActivityAt: DateTime.now(),
          fcmToken: await LocalNotificationHelper.instance.getToken(),
        );
      } on DeviceNotFound {
        await deviceRepository.store(
          id: deviceInfo.id,
          userId: user.id,
          model: deviceInfo.model,
          platform: deviceInfo.platform,
          fcmToken: await LocalNotificationHelper.instance.getToken(),
        );
      }
    } catch (e, s) {
      AppLogger.error(e.toString(), stackTrace: s);
    }

    return user;
  }

  Future<User?> getLoggedUserFromServer() async {
    try {
      final authRepository = AuthRepositoryImpl(
        authDatasource: AuthFirebaseDatasource(),
      );

      final userCredential = await authRepository.getCurrentUser();

      return await getUserByCredentials(
        userCredential,
        storeUserIfNotFound: false,
      );
    } catch (e) {
      return null;
    }
  }
}
