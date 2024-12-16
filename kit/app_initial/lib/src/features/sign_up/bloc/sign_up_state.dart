import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  const SignUpState({
    required this.isSigningUp,
  });

  const SignUpState.initial({
    this.isSigningUp = false,
  });

  final bool isSigningUp;

  SignUpState copyWith({
    bool? isSigningUp,
  }) {
    return SignUpState(
      isSigningUp: isSigningUp ?? this.isSigningUp,
    );
  }

  @override
  List<Object> get props => [
        isSigningUp,
      ];
}
