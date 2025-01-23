import 'dart:async';

import 'package:app_helpers/app_helpers.dart';
import 'package:app_initial/src/facades/facades.dart';
import 'package:app_initial/src/features/forgot_password/views/views.dart';
import 'package:app_initial/src/features/sign_in/bloc/bloc.dart';
import 'package:app_initial/src/features/sign_up/views/views.dart';
import 'package:app_initial/src/helpers/helpers.dart';
import 'package:app_initial/src/models/models.dart';
import 'package:app_initial/src/repositories/auth/auth.dart';
import 'package:app_initial/src/repositories/device/device.dart';
import 'package:app_initial/src/repositories/user/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({
    required this.authRepository,
    required this.userRepository,
    required this.deviceRepository,
  }) : super(const SignInState.initial()) {
    on<SignInWithEmailAndPassword>(_onLoginWithEmailAndPassword);
    on<SignInWithGoogleAccount>(_onLoginWithGoogleAccount);
    on<SignInWithAppleAccount>(_onLoginWithAppleAccount);
    on<SignInWithFacebookAccount>(_onLoginWithFacebookAccount);
    on<SignUpAccount>(_onSignUpAccount);
    on<ForgotPassword>(_onForgotPassword);
  }

  final AuthRepository authRepository;
  final UserRepository userRepository;
  final DeviceRepository deviceRepository;

  Future<void> _getUserAndSaveState(UserCredential userCredential) async {
    final user = await AuthHelper.instance.getUserByCredentials(userCredential);

    Auth.instance.setUser(user);

    Router.instance.refresh();
  }

  final FormGroup form = FormGroup({
    'email': FormControl<String>(
      value: '',
      validators: [Validators.required, Validators.email],
    ),
    'password': FormControl<String>(
      value: '',
      validators: [Validators.required, Validators.minLength(8)],
    ),
  });

  Future<void> _onLoginWithEmailAndPassword(
    SignInWithEmailAndPassword event,
    Emitter<SignInState> emit,
  ) async {
    if (!form.valid) {
      form.markAllAsTouched();
      return;
    }

    if (state.isSingingWithEmailAndPassword) return;

    emit(state.copyWith(isSingingWithEmailAndPassword: true));

    try {
      final userCredential = await authRepository.signInWithEmailAndPassword(
        email: form.control('email').value as String,
        password: form.control('password').value as String,
      );

      await _getUserAndSaveState(userCredential);
    } on EmailDoesNotVerifiedException {
      CustomSnackbar.instance.info(
        text: Localization.instance.tr.signIn_emailDoesNotVerified,
      );
      await authRepository.signOut();
    } on InvalidCredentialException {
      CustomSnackbar.instance.error(
        text: Localization.instance.tr.signIn_invalidCredential,
      );
    } on WrongPasswordException {
      CustomSnackbar.instance.error(
        text: Localization.instance.tr.signIn_wrongPassword,
      );
    } on UserDisabledException {
      CustomSnackbar.instance.error(
        text: Localization.instance.tr.signIn_userDisabled,
      );
    } catch (e, s) {
      CustomSnackbar.instance.error(
        text: Localization.instance.tr.generalError,
      );

      AppLogger.error(e.toString(), stackTrace: s);
    } finally {
      emit(state.copyWith(isSingingWithEmailAndPassword: false));
    }
  }

  Future<void> _onLoginWithGoogleAccount(
    SignInWithGoogleAccount event,
    Emitter<SignInState> emit,
  ) async {
    if (state.isSingingWithGoogle) return;

    emit(state.copyWith(isSingingWithGoogle: true));

    try {
      final googleSignInAccount = await AuthHelper.instance.signInWithGoogle();

      final googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final userCredentials = await authRepository.signInWithGoogle(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      await _getUserAndSaveState(userCredentials);
    } on CancelledByUserException {
      return;
    } on AccountExistsWithDifferentCredentialException {
      CustomSnackbar.instance.error(
        text: Localization.instance.tr.exception_credentialAlreadyExists,
      );
    } on PermissionDeniedUsers catch (e, s) {
      CustomSnackbar.instance.error(
        text: Localization.instance.tr.contactSupport,
      );
      AppLogger.error(e.toString(), stackTrace: s);
      await authRepository.signOut();
    } catch (e, s) {
      CustomSnackbar.instance.error(
        text: Localization.instance.tr.generalError,
      );

      AppLogger.error(e.toString(), stackTrace: s);
    } finally {
      emit(state.copyWith(isSingingWithGoogle: false));
    }
  }

  Future<void> _onLoginWithAppleAccount(
    SignInWithAppleAccount event,
    Emitter<SignInState> emit,
  ) async {
    if (state.isSingingWithApple) return;

    emit(state.copyWith(isSingingWithApple: true));

    try {
      final appleCredential = await AuthHelper.instance.signInWithApple();

      final userCredentials = await authRepository.signInWithApple(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      await _getUserAndSaveState(userCredentials);
    } on CancelledByUserException {
      return;
    } on AccountExistsWithDifferentCredentialException {
      CustomSnackbar.instance.error(
        text: Localization.instance.tr.exception_credentialAlreadyExists,
      );
    } catch (e, s) {
      CustomSnackbar.instance.error(
        text: Localization.instance.tr.generalError,
      );
      AppLogger.error(e.toString(), stackTrace: s);
    } finally {
      emit(state.copyWith(isSingingWithApple: false));
    }
  }

  Future<void> _onLoginWithFacebookAccount(
    SignInWithFacebookAccount event,
    Emitter<SignInState> emit,
  ) async {
    if (state.isSingingWithFacebook) return;

    emit(state.copyWith(isSingingWithFacebook: true));

    try {
      final (loginResult, rawNonce) =
          await AuthHelper.instance.signInWithFacebook();

      final userCredentials = await authRepository.signInWithFacebook(
        accessToken: loginResult.accessToken!.tokenString,
        rawNonce: rawNonce,
      );

      await _getUserAndSaveState(userCredentials);
    } on CancelledByUserException {
      return;
    } on AccountExistsWithDifferentCredentialException {
      CustomSnackbar.instance.error(
        text: Localization.instance.tr.exception_credentialAlreadyExists,
      );
    } catch (e, s) {
      CustomSnackbar.instance.error(
        text: Localization.instance.tr.generalError,
      );
      AppLogger.error(e.toString(), stackTrace: s);
    } finally {
      emit(state.copyWith(isSingingWithFacebook: false));
    }
  }

  Future<void> _onSignUpAccount(
    SignUpAccount event,
    Emitter<SignInState> emit,
  ) async {
    final value = await Router.instance.goRouter
        .pushNamed<Map<String, String>>(SignUpScreen.path);

    if (value == null) return;

    form.control('email').value = value['email'];
    form.control('password').value = value['password'];

    CustomSnackbar.instance
        .info(text: Localization.instance.tr.signIn_emailValidationSent);
  }

  Future<void> _onForgotPassword(
    ForgotPassword event,
    Emitter<SignInState> emit,
  ) async {
    final email = await Router.instance.goRouter.pushNamed<String>(
      ForgotPasswordScreen.path,
      queryParameters: {
        'email': form.control('email').value,
      },
    );

    if (email == null) return;

    form.control('email').value = email;
  }
}
