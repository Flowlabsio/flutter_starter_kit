import 'package:app_initial/src/helpers/helpers.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ProfileState extends Equatable {
  const ProfileState({
    required this.isUpdatingData,
    required this.isUpdatingPhoto,
    required this.imageUser,
    required this.initials,
  });

  const ProfileState.initial({
    this.isUpdatingData = false,
    this.isUpdatingPhoto = false,
    this.imageUser,
    this.initials = '',
  });

  final bool isUpdatingData;
  final bool isUpdatingPhoto;
  final String? imageUser;
  final String initials;

  ProfileState copyWith({
    bool? isUpdatingData,
    bool? isUpdatingPhoto,
    Parameter<String?>? imageUser,
    String? initials,
  }) {
    return ProfileState(
      isUpdatingData: isUpdatingData ?? this.isUpdatingData,
      isUpdatingPhoto: isUpdatingPhoto ?? this.isUpdatingPhoto,
      imageUser: imageUser == null ? this.imageUser : imageUser.value,
      initials: initials ?? this.initials,
    );
  }

  @override
  List<Object?> get props => [
        isUpdatingData,
        isUpdatingPhoto,
        imageUser,
        initials,
      ];
}
