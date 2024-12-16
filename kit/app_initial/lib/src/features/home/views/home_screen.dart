import 'package:app_initial/src/features/home/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen {
  const HomeScreen();

  static const path = '/home';

  static GoRoute route({
    List<RouteBase> routes = const [],
  }) =>
      GoRoute(
        path: path,
        name: path,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => HomeBloc()
              ..add(HomeInitial())
              ..add(HomeListen()),
            child: const HomePage(),
          );
        },
        routes: routes,
      );
}
