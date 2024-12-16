sealed class ForgotPasswordEvent {}

class ForgotPasswordInit extends ForgotPasswordEvent {
  ForgotPasswordInit({
    this.initialEmail = '',
  });

  final String initialEmail;
}

class SendForgotPasswordEmail extends ForgotPasswordEvent {
  SendForgotPasswordEmail();
}
