import 'package:equatable/equatable.dart';

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    required this.isSendingEmail,
  });

  const ForgotPasswordState.initial({
    this.isSendingEmail = false,
  });

  final bool isSendingEmail;

  ForgotPasswordState copyWith({
    bool? isSendingEmail,
  }) {
    return ForgotPasswordState(
      isSendingEmail: isSendingEmail ?? this.isSendingEmail,
    );
  }

  @override
  List<Object> get props => [
        isSendingEmail,
      ];
}
