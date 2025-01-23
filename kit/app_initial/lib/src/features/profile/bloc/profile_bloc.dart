import 'package:app_helpers/app_helpers.dart';
import 'package:app_initial/src/facades/facades.dart';
import 'package:app_initial/src/features/profile/bloc/bloc.dart';
import 'package:app_initial/src/helpers/helpers.dart';
import 'package:app_initial/src/repositories/storage/storage.dart';
import 'package:app_initial/src/repositories/user/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required this.userRepository,
    required this.storageRepository,
    required String? imageUser,
    required String initials,
  }) : super(
          ProfileState.initial(
            imageUser: imageUser,
            initials: initials,
          ),
        ) {
    on<ProfileUpdate>(_onProfileUpdate);
    on<UpdateUserProfilePhoto>(_onUpdateUserProfilePhoto);
    on<DeleteUserProfilePhoto>(_onDeleteUserProfilePhoto);
    on<UpdateInitials>(_onUpdateInitials);
    on<UpdateImageUser>(_onUpdateImageUser);
  }

  final UserRepository userRepository;
  final StorageRepository storageRepository;

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

  void init() {
    final user = Auth.instance.user()!;

    form.control('firstName').value = user.firstName;
    form.control('lastName').value = user.lastName;
    form.control('email').value = user.email;
  }

  Future<void> _onProfileUpdate(
    ProfileUpdate event,
    Emitter<ProfileState> emit,
  ) async {
    if (!form.valid) {
      form.markAllAsTouched();
      return;
    }

    if (state.isUpdatingData) return;

    emit(state.copyWith(isUpdatingData: true));

    try {
      final user = await userRepository.update(
        id: Auth.instance.user()!.id,
        firstName: form.control('firstName').value as String,
        lastName: form.control('lastName').value as String,
      );

      Auth.instance.setUser(user);

      add(UpdateInitials());

      userUpdateNotifier.emit(user);

      CustomSnackbar.instance.info(
        text: Localization.instance.tr.profile_userUpdated,
      );
    } catch (e, s) {
      CustomSnackbar.instance.error(
        text: Localization.instance.tr.generalError,
      );
      AppLogger.error(e.toString(), stackTrace: s);
    } finally {
      emit(state.copyWith(isUpdatingData: false));
    }
  }

  Future<void> _onUpdateUserProfilePhoto(
    UpdateUserProfilePhoto event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.isUpdatingPhoto) return;

    emit(state.copyWith(isUpdatingPhoto: true));

    Security.instance.isPaused = true;

    try {
      final hasPermission = await PermissionHelper.instance.requestPermission(
        permission: Permission.camera,
        title: Localization.instance.tr.camera,
        message: Localization.instance.tr.profile_messageActivePermission,
        showRequiredDialog: true,
      );

      if (!hasPermission) return;

      final image = await ImagePicker().pickImage(
        source: event.source,
        maxWidth: 400,
      );

      if (image == null) return;

      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        compressQuality: 100,
        aspectRatio: const CropAspectRatio(
          ratioX: 1,
          ratioY: 1,
        ),
      );

      if (croppedFile == null) return;

      final bytes = await croppedFile.readAsBytes();

      final user = Auth.instance.user()!;

      if (user.photo != null) {
        await storageRepository.delete(
          filename: user.photo!,
        );
      }

      final filename =
          '/users/${user.id}/profile/${DateTime.now().millisecondsSinceEpoch}.jpg';

      await storageRepository.write(
        filename: filename,
        bytes: bytes,
      );

      final updatedUser = await userRepository.update(
        id: user.id,
        photo: Parameter(filename),
      );

      Auth.instance.setUser(updatedUser);

      add(UpdateImageUser());

      userUpdateNotifier.emit(updatedUser);

      CustomSnackbar.instance.info(
        text: Localization.instance.tr.profile_imageUpdated,
      );
    } catch (e, s) {
      CustomSnackbar.instance.error(
        text: Localization.instance.tr.generalError,
      );
      AppLogger.error(e.toString(), stackTrace: s);
    } finally {
      emit(state.copyWith(isUpdatingPhoto: false));
      Security.instance.isPaused = false;
    }
  }

  Future<void> _onDeleteUserProfilePhoto(
    DeleteUserProfilePhoto event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.isUpdatingPhoto) return;

    emit(state.copyWith(isUpdatingPhoto: true));

    try {
      final user = Auth.instance.user()!;

      if (user.photo == null) return;

      await storageRepository.delete(
        filename: user.photo!,
      );

      final updatedUser = await userRepository.update(
        id: user.id,
        photo: const Parameter(null),
      );

      Auth.instance.setUser(updatedUser);

      add(UpdateImageUser());

      userUpdateNotifier.emit(updatedUser);

      CustomSnackbar.instance.info(
        text: Localization.instance.tr.profile_imageDeleted,
      );
    } catch (e, s) {
      CustomSnackbar.instance.error(
        text: Localization.instance.tr.generalError,
      );

      AppLogger.error(e.toString(), stackTrace: s);
    } finally {
      emit(state.copyWith(isUpdatingPhoto: false));
    }
  }

  Future<void> _onUpdateInitials(
    UpdateInitials event,
    Emitter<ProfileState> emit,
  ) async {
    final user = Auth.instance.user()!;

    final firstName = user.firstName;
    final lastName = user.lastName;

    final nameWasSet = firstName.isNotEmpty && lastName.isNotEmpty;

    if (!nameWasSet) return;

    final initials = '${firstName[0]}${lastName[0]}'.toUpperCase();

    emit(state.copyWith(initials: initials));
  }

  Future<void> _onUpdateImageUser(
    UpdateImageUser event,
    Emitter<ProfileState> emit,
  ) async {
    final user = Auth.instance.user()!;

    final photo = user.photo;

    emit(state.copyWith(imageUser: Parameter(photo)));
  }
}
