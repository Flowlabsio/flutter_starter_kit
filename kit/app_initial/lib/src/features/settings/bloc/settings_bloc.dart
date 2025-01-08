import 'package:app_helpers/app_helpers.dart';
import 'package:app_initial/src/enums/enums.dart';
import 'package:app_initial/src/facades/facades.dart';
import 'package:app_initial/src/features/settings/bloc/bloc.dart';
import 'package:app_initial/src/helpers/helpers.dart';
import 'package:app_initial/src/repositories/auth/auth.dart';
import 'package:app_initial/src/repositories/storage/storage.dart';
import 'package:app_initial/src/repositories/user/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required this.authRepository,
    required this.userRepository,
    required this.storageRepository,
  }) : super(const SettingsState.initial()) {
    on<SettingsInit>(_onSettingsInit);
    on<DeleteAccount>(_onDeleteAccount);
    on<SignOutSettings>(_onSignOutSettings);
  }

  final AuthRepository authRepository;
  final UserRepository userRepository;
  final StorageRepository storageRepository;

  final FormGroup formDeleteAccount = FormGroup({
    'password': FormControl<String>(
      value: '',
      validators: [Validators.required, Validators.minLength(8)],
    ),
  });

  Future<void> _onSettingsInit(
    SettingsInit event,
    Emitter<SettingsState> emit,
  ) async {
    if (state.isFetchingProviders) return;

    emit(state.copyWith(isFetchingProviders: true));

    try {
      if (!Auth.instance.check()) return;

      final providers = await authRepository.providers();

      emit(state.copyWith(userProviders: providers));
    } catch (e, s) {
      CustomSnackbar.instance.error(
        text: Localization.instance.tr.generalError,
      );

      AppLogger.error(e.toString(), stackTrace: s);
    } finally {
      emit(state.copyWith(isFetchingProviders: false));
    }
  }

  Future<void> _onDeleteAccount(
    DeleteAccount event,
    Emitter<SettingsState> emit,
  ) async {
    if (state.isDeletingAccount) return;

    emit(state.copyWith(isDeletingAccount: true));

    final provider = state.userProviders.first;

    try {
      final user = Auth.instance.user()!;

      if (provider == AuthProvider.apple) {
        final appleCredential = await AuthHelper.instance.signInWithApple();

        await authRepository.signInWithApple(
          idToken: appleCredential.identityToken,
          accessToken: appleCredential.authorizationCode,
        );
      } else if (provider == AuthProvider.google) {
        final googleCredential = await AuthHelper.instance.signInWithGoogle();

        final googleSignInAuthentication =
            await googleCredential.authentication;

        await authRepository.signInWithGoogle(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
      } else if (provider == AuthProvider.emailAndPassword) {
        await authRepository.signInWithEmailAndPassword(
          email: user.email,
          password: formDeleteAccount.control('password').value as String,
        );
      } else if (provider == AuthProvider.facebook) {
        final (facebookCredential, rawNonce) =
            await AuthHelper.instance.signInWithFacebook();

        await authRepository.signInWithFacebook(
          accessToken: facebookCredential.accessToken!.tokenString,
          rawNonce: rawNonce,
        );
      }

      await userRepository.deleteById(user.id);

      await storageRepository.deleteAll(path: 'users/${user.id}');

      await authRepository.delete();

      await Preference.instance.removePreference();

      await Security.instance.removeSecurity();

      add(SignOutSettings());
    } on CancelledByUserException {
      return;
    } on PermissionDeniedUsers catch (e, s) {
      CustomSnackbar.instance.error(
        text: Localization.instance.tr.contactSupport,
      );
      AppLogger.error(e.toString(), stackTrace: s);
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
      emit(state.copyWith(isDeletingAccount: false));
    }
  }

  Future<void> _onSignOutSettings(
    SignOutSettings event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      await authRepository.signOut();
    } catch (e, s) {
      AppLogger.error(e.toString(), stackTrace: s);
    }

    Auth.instance.setUser(null);
    Router.instance.refresh();
  }
}
