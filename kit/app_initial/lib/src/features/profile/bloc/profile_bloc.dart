import 'package:app_helpers/app_helpers.dart';
import 'package:app_initial/src/facades/facades.dart';
import 'package:app_initial/src/features/profile/bloc/bloc.dart';
import 'package:app_initial/src/helpers/data_notifier.dart';
import 'package:app_initial/src/repositories/user/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required this.userRepository,
  }) : super(const ProfileState.initial()) {
    on<ProfileInit>(_onProfileInit);
    on<ProfileUpdate>(_onProfileUpdate);
  }

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
        disabled: true,
      ),
    },
  );

  Future<void> _onProfileInit(
    ProfileInit event,
    Emitter<ProfileState> emit,
  ) async {
    final user = Auth.instance.user();

    if (user != null) {
      form.control('firstName').value = user.firstName;
      form.control('lastName').value = user.lastName;
      form.control('email').value = user.email;
    }
  }

  Future<void> _onProfileUpdate(
    ProfileUpdate event,
    Emitter<ProfileState> emit,
  ) async {
    if (!form.valid) {
      form.markAllAsTouched();
      return;
    }

    if (state.isUpdating) return;

    emit(state.copyWith(isUpdating: true));

    try {
      final user = await userRepository.update(
        id: Auth.instance.user()!.id,
        firstName: form.control('firstName').value as String,
        lastName: form.control('lastName').value as String,
      );

      Auth.instance.setUser(user);

      userUpdateNotifier.emit(user);

      CustomSnackbar.instance.success(
        text: Localization.instance.tr.profile_userUpdated,
      );
    } catch (e, s) {
      CustomSnackbar.instance.error(
        text: Localization.instance.tr.generalError,
      );
      AppLogger.error(e.toString(), stackTrace: s);
    } finally {
      emit(state.copyWith(isUpdating: false));
    }
  }
}
