import 'package:app_initial/src/datasources/datasources.dart';
import 'package:app_initial/src/features/settings/settings.dart';
import 'package:app_initial/src/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen {
  const SettingsScreen();

  static const path = '/settings';

  static GoRoute route({
    List<RouteBase> routes = const [],
  }) =>
      GoRoute(
        path: path,
        name: path,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => SettingsBloc(
              authRepository: AuthRepositoryImpl(
                authDatasource: AuthFirebaseDatasource(),
              ),
              userRepository: UserRepositoryImpl(
                userDatasource: UserFirebaseDatasource(),
              ),
              storageRepository: StorageRepositoryImpl(
                storageDatasource: StorageFirebaseDatasource(),
              ),
            )..add(SettingsInit()),
            child: const SettingsPage(),
          );
        },
        routes: routes,
      );
}
