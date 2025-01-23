import 'package:app_initial/src/datasources/notification/notification_firebase_datasource.dart';
import 'package:app_initial/src/features/notifications/bloc/bloc.dart';
import 'package:app_initial/src/features/notifications/views/views.dart';
import 'package:app_initial/src/repositories/notification/notification.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NotificationsScreen {
  const NotificationsScreen();

  static const path = '/notifications';

  static GoRoute route({
    List<RouteBase> routes = const [],
  }) =>
      GoRoute(
        path: path,
        name: path,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => NotificationsBloc(
              notificationRepository: NotificationRepositoryImpl(
                notificationDatasource: NotificationFirebaseDatasource(),
              ),
            )..add(LoadNextNotificationPage(isRefresh: true)),
            child: const NotificationsPage(),
          );
        },
        routes: routes,
      );
}
