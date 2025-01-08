import 'dart:async';

import 'package:app_initial/src/enums/enums.dart';
import 'package:app_initial/src/models/models.dart';

abstract class AuthRepository {
  Future<UserCredential> getCurrentUser();

  Future<UserCredential> signInWithGoogle({
    String? idToken,
    String? accessToken,
  });

  Future<UserCredential> signInWithApple({
    String? idToken,
    String? accessToken,
  });

  Future<UserCredential> signInWithFacebook({
    String? idToken,
    String? accessToken,
    String? rawNonce,
  });

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> sendPasswordResetEmail(String email);

  Future<void> signOut();

  Future<void> delete();

  Future<List<AuthProvider>> providers();

  Future<void> resetPassword(String password);
}

class EmailDoesNotVerifiedException implements Exception {}

class WrongPasswordException implements Exception {}

class InvalidEmailFormatException implements Exception {}

class InvalidCredentialException implements Exception {}

class EmailAlreadyInUseException implements Exception {}

class WeakPasswordException implements Exception {}

class UserDisabledException implements Exception {}

class UserAuthNotFoundException implements Exception {}

class AccountExistsWithDifferentCredentialException implements Exception {}
