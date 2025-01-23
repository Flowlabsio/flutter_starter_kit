import 'package:app_initial/src/features/splash/views/views.dart';
import 'package:app_initial/src/helpers/helpers.dart';
import 'package:go_router/go_router.dart';

class SplashScreen {
  const SplashScreen();

  static const path = '/splash';

  static GoRoute route({
    List<RouteBase> routes = const [],
  }) =>
      GoRoute(
        path: path,
        name: path,
        pageBuilder: (context, state) {
          return RouteAnimation.noAnimationTransition(
            key: state.pageKey,
            child: const SplashPage(),
          );
        },
        routes: routes,
      );
}
