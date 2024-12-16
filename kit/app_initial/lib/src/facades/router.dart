import 'package:app_core/app_core.dart';
import 'package:app_helpers/app_helpers.dart';
import 'package:app_initial/src/datasources/auth/auth.dart';
import 'package:app_initial/src/datasources/user/user.dart';
import 'package:app_initial/src/facades/facades.dart';
import 'package:app_initial/src/features/futures.dart';
import 'package:app_initial/src/helpers/connectivity_helper.dart';
import 'package:app_initial/src/repositories/auth/auth.dart';
import 'package:app_initial/src/repositories/user/user.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';

Future<bool> checkIsLogged() async {
  try {
    final authRepository = AuthRepositoryImpl(
      authDatasource: AuthFirebaseDatasource(),
    );

    final userRepository = UserRepositoryImpl(
      userDatasource: UserFirebaseDatasource(),
    );

    final userCredential = await authRepository.getCurrentUser();

    final user = await userRepository.findById(userCredential.id);

    Auth.instance.setUser(user);

    return true;
  } catch (e, s) {
    AppLogger.error(e.toString(), stackTrace: s);

    return false;
  }
}

final publicRoutes = [
  SignInScreen.path,
  '${SignInScreen.path}${SignUpScreen.path}',
  '${SignInScreen.path}${ForgotPasswordScreen.path}',
];

const initialRoute = '/';

class Router {
  Router._singleton();

  static final Router instance = Router._singleton();

  bool isFirstTime = true;
  String tryToNavigate = '';

  bool canPop() {
    return goRouter.canPop();
  }

  void pop<T extends Object?>([T? result]) {
    goRouter.pop(result);
  }

  Future<T?> pushNamed<T extends Object?>(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    return goRouter.pushNamed<T>(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  void goNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    goRouter.goNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  void refresh() {
    goRouter.refresh();
  }

  final goRouter = GoRouter(
    navigatorKey: AppKeys.instance.rootNavigatorKey,
    initialLocation: initialRoute,
    routes: [
      SignInScreen.route(
        routes: [
          SignUpScreen.route(),
          ForgotPasswordScreen.route(),
        ],
      ),
      HomeScreen.route(
        routes: [
          ProfileScreen.route(),
          SettingsScreen.route(),
        ],
      ),
    ],
    redirect: (context, state) async {
      final router = Router.instance;
      final redirectTo = state.uri.path;

      try {
        final isPublicRoute = publicRoutes.contains(redirectTo);

        var isAuth = Auth.instance.check();

        if (router.isFirstTime && !isAuth) {
          isAuth = await checkIsLogged();
        }

        if (!isAuth) {
          if (redirectTo == initialRoute) {
            return SignInScreen.path;
          }

          if (!isPublicRoute) {
            router.tryToNavigate = state.uri.toString();
            return SignInScreen.path;
          }
        } else {
          if (redirectTo == initialRoute) {
            return HomeScreen.path;
          }

          if (isPublicRoute) {
            return HomeScreen.path;
          }

          final tryToNavigate = router.tryToNavigate;
          final tryToNavigateIsPublic = publicRoutes.contains(tryToNavigate);

          if (tryToNavigate.isNotEmpty && !tryToNavigateIsPublic) {
            router.tryToNavigate = '';
            return tryToNavigate;
          }
        }

        return state.uri.toString();
      } finally {
        if (router.isFirstTime) {
          router.isFirstTime = false;

          // REMOVE NATIVE SPLASH SCREEN
          FlutterNativeSplash.remove();

          // CHECK CONNECTIVITY
          ConnectivityHelper.instance.initialize();
        }
      }
    },
  );
}
