import 'package:equatable/equatable.dart';

class SignInState extends Equatable {
  const SignInState({
    required this.isSingingWithEmailAndPassword,
    required this.isSingingWithGoogle,
    required this.isSingingWithApple,
    required this.isSingingWithFacebook,
  });

  const SignInState.initial({
    this.isSingingWithEmailAndPassword = false,
    this.isSingingWithGoogle = false,
    this.isSingingWithApple = false,
    this.isSingingWithFacebook = false,
  });

  final bool isSingingWithEmailAndPassword;
  final bool isSingingWithGoogle;
  final bool isSingingWithApple;
  final bool isSingingWithFacebook;

  SignInState copyWith({
    bool? isSingingWithEmailAndPassword,
    bool? isSingingWithGoogle,
    bool? isSingingWithApple,
    bool? isSingingWithFacebook,
  }) {
    return SignInState(
      isSingingWithEmailAndPassword:
          isSingingWithEmailAndPassword ?? this.isSingingWithEmailAndPassword,
      isSingingWithGoogle: isSingingWithGoogle ?? this.isSingingWithGoogle,
      isSingingWithApple: isSingingWithApple ?? this.isSingingWithApple,
      isSingingWithFacebook:
          isSingingWithFacebook ?? this.isSingingWithFacebook,
    );
  }

  @override
  List<Object> get props => [
        isSingingWithEmailAndPassword,
        isSingingWithGoogle,
        isSingingWithApple,
        isSingingWithFacebook,
      ];
}
