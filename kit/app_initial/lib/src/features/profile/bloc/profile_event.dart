import 'package:image_picker/image_picker.dart';

sealed class ProfileEvent {}

class ProfileUpdate extends ProfileEvent {
  ProfileUpdate();
}

class UpdateUserProfilePhoto extends ProfileEvent {
  UpdateUserProfilePhoto({
    required this.source,
  });

  final ImageSource source;
}

class DeleteUserProfilePhoto extends ProfileEvent {
  DeleteUserProfilePhoto();
}

class UpdateInitials extends ProfileEvent {
  UpdateInitials();
}

class UpdateImageUser extends ProfileEvent {
  UpdateImageUser();
}
