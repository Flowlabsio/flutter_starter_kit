enum AuthProvider {
  emailAndPassword,
  google,
  apple;

  static AuthProvider fromString(String value) {
    switch (value) {
      case 'google.com':
        return AuthProvider.google;
      case 'apple.com':
        return AuthProvider.apple;
      case 'password':
        return AuthProvider.emailAndPassword;
      default:
        throw Exception('Unknown UserAuthProvider');
    }
  }

  String get providerId {
    switch (this) {
      case AuthProvider.google:
        return 'google.com';
      case AuthProvider.apple:
        return 'apple.com';
      case AuthProvider.emailAndPassword:
        return 'password';
    }
  }
}
