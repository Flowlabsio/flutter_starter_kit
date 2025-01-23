sealed class SignInEvent {}

class SignInWithEmailAndPassword extends SignInEvent {
  SignInWithEmailAndPassword();
}

class SignInWithGoogleAccount extends SignInEvent {
  SignInWithGoogleAccount();
}

class SignInWithAppleAccount extends SignInEvent {
  SignInWithAppleAccount();
}

class SignInWithFacebookAccount extends SignInEvent {
  SignInWithFacebookAccount();
}

class SignUpAccount extends SignInEvent {
  SignUpAccount();
}

class ForgotPassword extends SignInEvent {
  ForgotPassword();
}
