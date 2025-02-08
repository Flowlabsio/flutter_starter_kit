import 'package:app_initial/src/facades/facades.dart';
import 'package:app_initial/src/features/features.dart';

class AppNavigator {
  AppNavigator._singleton();

  static final AppNavigator instance = AppNavigator._singleton();

  Future<String?> pushForgotPassword({
    String? email,
  }) {
    return Router.instance.goRouter.pushNamed<String>(
      ForgotPasswordScreen.path,
      queryParameters: {
        'email': email ?? '',
      },
    );
  }
}
