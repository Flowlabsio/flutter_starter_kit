import 'package:app_initial/src/datasources/auth/auth.dart';
import 'package:app_initial/src/datasources/device/device.dart';
import 'package:app_initial/src/datasources/user/user.dart';
import 'package:app_initial/src/features/sign_in/bloc/bloc.dart';
import 'package:app_initial/src/features/sign_in/views/views.dart';
import 'package:app_initial/src/helpers/helpers.dart';
import 'package:app_initial/src/repositories/auth/auth.dart';
import 'package:app_initial/src/repositories/device/device.dart';
import 'package:app_initial/src/repositories/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignInScreen {
  const SignInScreen();

  static const path = '/sign-in';

  static GoRoute route({
    List<RouteBase> routes = const [],
  }) =>
      GoRoute(
        path: path,
        name: path,
        pageBuilder: (context, state) {
          return RouteAnimation.slideUpToDownTransition(
            key: state.pageKey,
            curve: Curves.elasticInOut,
            duration: const Duration(milliseconds: 1000),
            child: BlocProvider(
              create: (context) => SignInBloc(
                authRepository: AuthRepositoryImpl(
                  authDatasource: AuthFirebaseDatasource(),
                ),
                userRepository: UserRepositoryImpl(
                  userDatasource: UserFirebaseDatasource(),
                ),
                deviceRepository: DeviceRepositoryImpl(
                  deviceDatasource: DeviceFirebaseDatasource(),
                ),
              ),
              child: const SignInPage(),
            ),
          );
        },
        routes: routes,
      );
}
