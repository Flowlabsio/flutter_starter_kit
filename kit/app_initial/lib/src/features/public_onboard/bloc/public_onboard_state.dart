import 'package:equatable/equatable.dart';

class PublicOnboardState extends Equatable {
  const PublicOnboardState({
    required this.index,
  });

  const PublicOnboardState.initial({
    this.index = 0,
  });

  final int index;

  PublicOnboardState copyWith({
    int? index,
  }) {
    return PublicOnboardState(
      index: index ?? this.index,
    );
  }

  @override
  List<Object> get props => [
        index,
      ];
}
