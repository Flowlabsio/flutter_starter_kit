import 'dart:io';

import 'package:app_helpers/app_helpers.dart';
import 'package:flutter/services.dart';
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
}
