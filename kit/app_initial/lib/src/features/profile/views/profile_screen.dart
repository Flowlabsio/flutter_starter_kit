import 'package:app_initial/src/datasources/storage/storage.dart';
import 'package:app_initial/src/datasources/user/user.dart';
import 'package:app_initial/src/facades/facades.dart';
import 'package:app_initial/src/features/profile/bloc/bloc.dart';
import 'package:app_initial/src/features/profile/views/views.dart';
import 'package:app_initial/src/repositories/storage/storage.dart';
import 'package:app_initial/src/repositories/user/user.dart';
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
          final user = Auth.instance.user()!;

          return BlocProvider(
            create: (context) => ProfileBloc(
              userRepository: UserRepositoryImpl(
                userDatasource: UserFirebaseDatasource(),
              ),
              storageRepository: StorageRepositoryImpl(
                storageDatasource: StorageFirebaseDatasource(),
              ),
              imageUser: user.photo,
              initials: user.initials,
            )..init(),
            child: const ProfilePage(),
          );
        },
        routes: routes,
      );
}
