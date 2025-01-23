import 'package:equatable/equatable.dart';

class UnlockState extends Equatable {
  const UnlockState({
    required this.isUnlocking,
  });

  const UnlockState.initial({
    this.isUnlocking = false,
  });

  final bool isUnlocking;

  UnlockState copyWith({
    bool? isUnlocking,
  }) {
    return UnlockState(
      isUnlocking: isUnlocking ?? this.isUnlocking,
    );
  }

  @override
  List<Object?> get props => [
        isUnlocking,
      ];
}
