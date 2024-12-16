import 'package:image_picker/image_picker.dart';

sealed class ProfileEvent {}

class ProfileInit extends ProfileEvent {
  ProfileInit();
}

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
