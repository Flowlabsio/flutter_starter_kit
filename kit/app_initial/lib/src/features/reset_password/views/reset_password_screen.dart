import 'package:app_initial/src/datasources/datasources.dart';
import 'package:app_initial/src/features/reset_password/reset_password.dart';
import 'package:app_initial/src/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordScreen {
  const ResetPasswordScreen();

  static const path = '/reset-password';

  static GoRoute route({
    List<RouteBase> routes = const [],
  }) =>
      GoRoute(
        path: path,
        name: path,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => ResetPasswordBloc(
              authRepository: AuthRepositoryImpl(
                authDatasource: AuthFirebaseDatasource(),
              ),
            ),
            child: const ResetPasswordPage(),
          );
        },
        routes: routes,
      );
}
