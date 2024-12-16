import 'package:equatable/equatable.dart';

class SignInState extends Equatable {
  const SignInState({
    required this.isSingingWithEmailAndPassword,
    required this.isSingingWithGoogle,
    required this.isSingingWithApple,
  });

  const SignInState.initial({
    this.isSingingWithEmailAndPassword = false,
    this.isSingingWithGoogle = false,
    this.isSingingWithApple = false,
  });

  final bool isSingingWithEmailAndPassword;
  final bool isSingingWithGoogle;
  final bool isSingingWithApple;

  SignInState copyWith({
    bool? isSingingWithEmailAndPassword,
    bool? isSingingWithGoogle,
    bool? isSingingWithApple,
  }) {
    return SignInState(
      isSingingWithEmailAndPassword:
          isSingingWithEmailAndPassword ?? this.isSingingWithEmailAndPassword,
      isSingingWithGoogle: isSingingWithGoogle ?? this.isSingingWithGoogle,
      isSingingWithApple: isSingingWithApple ?? this.isSingingWithApple,
    );
  }

  @override
  List<Object> get props => [
        isSingingWithEmailAndPassword,
        isSingingWithGoogle,
        isSingingWithApple,
      ];
}
