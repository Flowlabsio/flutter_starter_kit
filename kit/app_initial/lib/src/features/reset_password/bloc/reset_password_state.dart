import 'package:equatable/equatable.dart';

class ResetPasswordState extends Equatable {
  const ResetPasswordState({
    required this.isResetPassword,
  });

  const ResetPasswordState.initial({
    this.isResetPassword = false,
  });

  final bool isResetPassword;

  ResetPasswordState copyWith({
    bool? isResetPassword,
  }) {
    return ResetPasswordState(
      isResetPassword: isResetPassword ?? this.isResetPassword,
    );
  }

  @override
  List<Object> get props => [
        isResetPassword,
      ];
}
