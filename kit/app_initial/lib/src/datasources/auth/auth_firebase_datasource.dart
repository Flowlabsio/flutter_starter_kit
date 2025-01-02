import 'package:app_initial/src/datasources/auth/auth.dart';
import 'package:app_initial/src/enums/enums.dart';
import 'package:app_initial/src/models/models.dart';
import 'package:app_initial/src/repositories/auth/auth.dart';

import 'package:firebase_auth/firebase_auth.dart' as fa;

class AuthFirebaseDatasource implements AuthDatasource {
  final _firebaseAuth = fa.FirebaseAuth.instance;

  @override
  Future<UserCredential> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;

    if (user == null) {
      throw UserAuthNotFoundException();
    }

    return UserCredential(
      id: user.uid,
      email: user.email!,
      providers: await providers(),
    );
  }

  @override
  Future<UserCredential> signInWithGoogle({
    String? idToken,
    String? accessToken,
  }) async {
    final credentials = fa.OAuthProvider(
      AuthProvider.google.providerId,
    ).credential(
      accessToken: accessToken,
      idToken: idToken,
    );

    final uc = await fa.FirebaseAuth.instance.signInWithCredential(
      credentials,
    );

    return UserCredential(
      id: uc.user!.uid,
      email: uc.user!.email!,
      providers: const [AuthProvider.google],
    );
  }

  @override
  Future<UserCredential> signInWithApple({
    String? idToken,
    String? accessToken,
  }) async {
    final credentials = fa.OAuthProvider(
      AuthProvider.apple.providerId,
    ).credential(
      accessToken: accessToken,
      idToken: idToken,
    );

    final uc = await fa.FirebaseAuth.instance.signInWithCredential(
      credentials,
    );

    return UserCredential(
      id: uc.user!.uid,
      email: uc.user!.email!,
      providers: const [AuthProvider.apple],
    );
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!userCredential.user!.emailVerified) {
        throw EmailDoesNotVerifiedException();
      }

      return UserCredential(
        id: userCredential.user!.uid,
        email: userCredential.user!.email!,
        providers: const [AuthProvider.emailAndPassword],
      );
    } catch (e) {
      if (e is fa.FirebaseAuthException) {
        if (e.code == 'wrong-password') {
          throw WrongPasswordException();
        }

        if (e.code == 'invalid-email') {
          throw InvalidEmailFormatException();
        }

        if (e.code == 'invalid-credential') {
          throw InvalidCredentialException();
        }

        if (e.code == 'user-disabled') {
          throw UserDisabledException();
        }
      }
      rethrow;
    }
  }

  @override
  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user!.sendEmailVerification();

      return UserCredential(
        id: userCredential.user!.uid,
        email: userCredential.user!.email!,
        providers: const [AuthProvider.emailAndPassword],
      );
    } catch (e) {
      if (e is fa.FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          throw EmailAlreadyInUseException();
        }

        if (e.code == 'weak-password') {
          throw WeakPasswordException();
        }

        if (e.code == 'invalid-email') {
          throw InvalidEmailFormatException();
        }
      }
      rethrow;
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> delete() async {
    await _firebaseAuth.currentUser!.delete();
  }

  @override
  Future<List<AuthProvider>> providers() async {
    final currentUser = fa.FirebaseAuth.instance.currentUser;

    if (currentUser == null) throw Exception('No currently signed-in user');

    final providers = <AuthProvider>[];
    for (final providerData in currentUser.providerData) {
      providers.add(AuthProvider.fromString(providerData.providerId));
    }

    return providers;
  }
}
