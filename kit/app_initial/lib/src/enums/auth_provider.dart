enum AuthProvider {
  emailAndPassword,
  google,
  apple,
  facebook;

  static AuthProvider fromString(String value) {
    switch (value) {
      case 'google.com':
        return AuthProvider.google;
      case 'apple.com':
        return AuthProvider.apple;
      case 'password':
        return AuthProvider.emailAndPassword;
      case 'facebook.com':
        return AuthProvider.facebook;
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
      case AuthProvider.facebook:
        return 'facebook.com';
    }
  }
}
