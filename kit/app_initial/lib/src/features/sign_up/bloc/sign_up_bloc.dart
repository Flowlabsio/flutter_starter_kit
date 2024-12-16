import 'dart:async';

import 'package:app_helpers/app_helpers.dart';
import 'package:app_initial/src/facades/facades.dart';
import 'package:app_initial/src/features/sign_up/bloc/bloc.dart';
import 'package:app_initial/src/helpers/helpers.dart';
import 'package:app_initial/src/repositories/repositories.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required this.authRepository,
    required this.userRepository,
  }) : super(const SignUpState.initial()) {
    on<SignUpWithEmailAndPassword>(_onSignUpWithEmailAndPassword);
  }

  final AuthRepository authRepository;
  final UserRepository userRepository;

  final FormGroup form = FormGroup(
    {
      'firstName': FormControl<String>(
        value: '',
        validators: [Validators.required],
      ),
      'lastName': FormControl<String>(
        value: '',
        validators: [Validators.required],
      ),
      'email': FormControl<String>(
        value: '',
        validators: [Validators.required, Validators.email],
      ),
      'password': FormControl<String>(
        value: '',
        validators: [Validators.required, Validators.minLength(8)],
      ),
      'repeatPassword': FormControl<String>(
        value: '',
        validators: [Validators.required],
      ),
    },
    validators: [
      CustomMustMatchValidator(
        controlName: 'password',
        matchingControlName: 'repeatPassword',
      ),
    ],
  );

  Future<void> _onSignUpWithEmailAndPassword(
    SignUpWithEmailAndPassword event,
    Emitter<SignUpState> emit,
  ) async {
    if (!form.valid) {
      form.markAllAsTouched();
      return;
    }

    if (state.isSigningUp) return;

    emit(state.copyWith(isSigningUp: true));

    try {
      final userCredential = await authRepository.signUpWithEmailAndPassword(
        email: form.control('email').value as String,
        password: form.control('password').value as String,
      );

      await userRepository.store(
        id: userCredential.id,
        firstName: form.control('firstName').value as String,
        lastName: form.control('lastName').value as String,
        email: userCredential.email,
      );

      await authRepository.signOut();

      Router.instance.pop({
        'email': form.control('email').value as String,
        'password': form.control('password').value as String,
      });
    } on EmailAlreadyInUseException {
      CustomSnackbar.instance.warning(
        text: Localization.instance.tr.signUp_emailAlreadyInUse,
      );
    } on WeakPasswordException {
      CustomSnackbar.instance.warning(
        text: Localization.instance.tr.signUp_weakPassword,
      );
    } on InvalidEmailFormatException {
      CustomSnackbar.instance.warning(
        text: Localization.instance.tr.signUp_InvalidEmailFormat,
      );
    } catch (e, s) {
      CustomSnackbar.instance
          .error(text: Localization.instance.tr.generalError);
      AppLogger.error(e.toString(), stackTrace: s);
    } finally {
      emit(state.copyWith(isSigningUp: false));
    }
  }
}
