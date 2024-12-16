class Env {
  static const String environment = String.fromEnvironment('ENV');

  static const String googleClientId =
      String.fromEnvironment('GOOGLE_CLIENT_ID');

  static const String appleServiceId =
      String.fromEnvironment('APPLE_SERVICE_ID');

  static const String appleRedirectUrl =
      String.fromEnvironment('APPLE_REDIRECT_URL');
}
