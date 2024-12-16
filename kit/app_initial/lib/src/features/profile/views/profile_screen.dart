import 'package:app_initial/src/datasources/datasources.dart';
import 'package:app_initial/src/features/profile/profile.dart';
import 'package:app_initial/src/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen {
  const ProfileScreen();

  static const path = '/profile';

  static GoRoute route({
    List<RouteBase> routes = const [],
  }) =>
      GoRoute(
        path: path,
        name: path,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => ProfileBloc(
              userRepository: UserRepositoryImpl(
                userDatasource: UserFirebaseDatasource(),
              ),
              storageRepository: StorageRepositoryImpl(
                storageDatasource: StorageFirebaseDatasource(),
              ),
            )..add(ProfileInit()),
            child: const ProfilePage(),
          );
        },
        routes: routes,
      );
}
