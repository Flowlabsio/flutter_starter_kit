import 'dart:async';

import 'package:app_initial/src/enums/enums.dart';
import 'package:app_initial/src/models/models.dart';

abstract class AuthDatasource {
  Future<UserCredential> getCurrentUser();

  Future<UserCredential> signInWithGoogle({
    String? idToken,
    String? accessToken,
  });

  Future<UserCredential> signInWithApple({
    String? idToken,
    String? accessToken,
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
}
