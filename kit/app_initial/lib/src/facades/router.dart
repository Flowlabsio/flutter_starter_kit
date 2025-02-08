import 'dart:async';

import 'package:app_core/app_core.dart';
import 'package:app_initial/src/facades/facades.dart';
import 'package:app_initial/src/features/features.dart';
import 'package:app_initial/src/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Router {
  Router._singleton();

  static final Router instance = Router._singleton();

  final publicRoutes = [
    SplashScreen.path,
    PublicOnboardScreen.path,
    SignInScreen.path,
    '${SignInScreen.path}${SignUpScreen.path}',
    '${SignInScreen.path}${ForgotPasswordScreen.path}',
  ];

  bool shownSplash = false;
  bool isFirstOpen = true;
  String tryToNavigate = '';

  void refresh() {
    goRouter.refresh();
  }

  GoRouter goRouter = GoRouter(
    navigatorKey: AppKeys.instance.rootNavigatorKey,
    initialLocation: SplashScreen.path,
    routes: [
      SplashScreen.route(),
      PublicOnboardScreen.route(),
      SignInScreen.route(
        routes: [
          SignUpScreen.route(),
          ForgotPasswordScreen.route(),
        ],
      ),
      ShellRoute(
        pageBuilder: (context, state, child) {
          return RouteAnimation.fadeTransition(
            duration: const Duration(milliseconds: 400),
            key: state.pageKey,
            child: AuthScaffold(
              child: child,
            ),
          );
        },
        routes: [
          HomeScreen.route(
            routes: [
              NotificationsScreen.route(),
              ProfileScreen.route(),
              SettingsScreen.route(
                routes: [
                  ResetPasswordScreen.route(),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: redirect,
  );
}

Future<String?> redirect(BuildContext context, GoRouterState state) async {
  final router = Router.instance;

  final shownSplash = router.shownSplash;
  final isFirstTime = router.isFirstOpen;
  final redirectTo = state.fullPath;
  final realRedirectTo = state.uri.toString();
  final isPublicRoute = router.publicRoutes.contains(redirectTo);
  final isAuth = Auth.instance.check();
  final isPublicOnboardCompleted = Session.instance.isPublicOnboardCompleted;

  if (redirectTo == SplashScreen.path && !shownSplash) {
    router.shownSplash = true;
    return realRedirectTo;
  }

  try {
    if (isFirstTime && !isPublicRoute && !isAuth) {
      router.tryToNavigate = realRedirectTo;
    }

    if (!isAuth) {
      if (!isPublicOnboardCompleted) {
        return PublicOnboardScreen.path;
      }

      if (redirectTo == SplashScreen.path ||
          redirectTo == PublicOnboardScreen.path ||
          !isPublicRoute) {
        return SignInScreen.path;
      }
    } else {
      if (redirectTo == SplashScreen.path || isPublicRoute) {
        return HomeScreen.path;
      }

      if (router.tryToNavigate.isNotEmpty) {
        final aux = router.tryToNavigate;
        router.tryToNavigate = '';
        return aux;
      }
    }

    return realRedirectTo;
  } finally {
    if (router.isFirstOpen) {
      router.isFirstOpen = false;
    }
  }
}
