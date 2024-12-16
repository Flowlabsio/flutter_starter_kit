import 'package:app_initial/src/datasources/auth/auth.dart';
import 'package:app_initial/src/enums/enums.dart';
import 'package:app_initial/src/models/models.dart';
import 'package:app_initial/src/repositories/auth/auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.authDatasource});

  final AuthDatasource authDatasource;

  @override
  Future<void> delete() {
    return authDatasource.delete();
  }

  @override
  Future<UserCredential> getCurrentUser() {
    return authDatasource.getCurrentUser();
  }

  @override
  Future<List<AuthProvider>> providers() {
    return authDatasource.providers();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) {
    return authDatasource.sendPasswordResetEmail(email);
  }

  @override
  Future<UserCredential> signInWithApple({
    String? idToken,
    String? accessToken,
  }) {
    return authDatasource.signInWithApple(
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return authDatasource.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<UserCredential> signInWithGoogle({
    String? idToken,
    String? accessToken,
  }) {
    return authDatasource.signInWithGoogle(
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  @override
  Future<void> signOut() {
    return authDatasource.signOut();
  }

  @override
  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return authDatasource.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
