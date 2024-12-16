import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  const ProfileState({
    required this.isUpdatingData,
    required this.isUpdatingPhoto,
    required this.isFetchingPhoto,
    required this.photoBytes,
  });

  ProfileState.initial({
    this.isUpdatingData = false,
    this.isUpdatingPhoto = false,
    this.isFetchingPhoto = false,
    Uint8List? photoBytes,
  }) : photoBytes = photoBytes ?? Uint8List(0);

  final bool isUpdatingData;
  final bool isUpdatingPhoto;
  final bool isFetchingPhoto;
  final Uint8List photoBytes;

  ProfileState copyWith({
    bool? isUpdatingData,
    bool? isUpdatingPhoto,
    bool? isFetchingPhoto,
    Uint8List? photoBytes,
  }) {
    return ProfileState(
      isUpdatingData: isUpdatingData ?? this.isUpdatingData,
      isUpdatingPhoto: isUpdatingPhoto ?? this.isUpdatingPhoto,
      isFetchingPhoto: isFetchingPhoto ?? this.isFetchingPhoto,
      photoBytes: photoBytes ?? this.photoBytes,
    );
  }

  @override
  List<Object?> get props => [
        isUpdatingData,
        isUpdatingPhoto,
        isFetchingPhoto,
        photoBytes,
      ];
}
