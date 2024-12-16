import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  const ProfileState({
    required this.isUpdating,
  });

  const ProfileState.initial({
    this.isUpdating = false,
  });

  final bool isUpdating;

  ProfileState copyWith({
    bool? isUpdating,
  }) {
    return ProfileState(
      isUpdating: isUpdating ?? this.isUpdating,
    );
  }

  @override
  List<Object> get props => [
        isUpdating,
      ];
}
