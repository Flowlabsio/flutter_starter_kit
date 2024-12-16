import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.userName,
  });

  const HomeState.initial({
    this.userName = '',
  });

  final String userName;

  HomeState copyWith({
    String? userName,
  }) {
    return HomeState(
      userName: userName ?? this.userName,
    );
  }

  @override
  List<Object> get props => [
        userName,
      ];
}
