import 'package:app_initial/src/features/public_onboard/bloc/bloc.dart';
import 'package:app_initial/src/features/public_onboard/views/views.dart';
import 'package:app_initial/src/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PublicOnboardScreen {
  const PublicOnboardScreen();

  static const path = '/public-onboard';

  static GoRoute route({
    List<RouteBase> routes = const [],
  }) =>
      GoRoute(
        path: path,
        name: path,
        pageBuilder: (context, state) {
          return RouteAnimation.slideDownToUpTransition(
            duration: const Duration(milliseconds: 1500),
            key: state.pageKey,
            child: BlocProvider(
              create: (context) =>
                  PublicOnboardBloc()..add(PublicOnboardListeners()),
              child: const PublicOnboardPage(),
            ),
            curve: Curves.elasticInOut,
          );
        },
        routes: routes,
      );
}
