import 'package:app_initial/src/datasources/auth/auth.dart';
import 'package:app_initial/src/datasources/user/user.dart';
import 'package:app_initial/src/features/sign_in/bloc/bloc.dart';
import 'package:app_initial/src/features/sign_in/views/views.dart';
import 'package:app_initial/src/repositories/auth/auth.dart';
import 'package:app_initial/src/repositories/user/user.dart';
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
        builder: (context, state) {
          return BlocProvider(
            create: (context) => SignInBloc(
              authRepository: AuthRepositoryImpl(
                authDatasource: AuthFirebaseDatasource(),
              ),
              userRepository: UserRepositoryImpl(
                userDatasource: UserFirebaseDatasource(),
              ),
            ),
            child: const SignInPage(),
          );
        },
        routes: routes,
      );
}
