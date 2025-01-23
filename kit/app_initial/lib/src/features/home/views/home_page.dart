import 'package:app_initial/l10n/l10n.dart';
import 'package:app_initial/src/features/home/bloc/bloc.dart';
import 'package:app_initial/src/features/notifications/views/views.dart';
import 'package:app_initial/src/features/profile/views/views.dart';
import 'package:app_initial/src/features/settings/views/views.dart';
import 'package:app_initial/src/helpers/helpers.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final buttonsProvider = Theme.of(context).buttonStyles;

    final userName = context.select((HomeBloc bloc) => bloc.state.userName);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          userName.isNotEmpty ? l10n.home_welcomeUser(userName) : l10n.home,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              context.pushNamed(NotificationsScreen.path);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
              style: buttonsProvider.primaryFilled,
              onPressed: () {
                context.pushNamed(ProfileScreen.path);
              },
              child: Text(l10n.profile),
            ),
            const SizedBox(height: UISpacing.space1x),
            FilledButton(
              style: buttonsProvider.primaryFilled,
              onPressed: () {
                context.pushNamed(SettingsScreen.path);
              },
              child: Text(l10n.settings),
            ),
            const SizedBox(height: UISpacing.space1x),
            FilledButton(
              style: buttonsProvider.primaryFilled,
              onPressed: () async {
                final hasPermission = await PermissionHelper.instance
                    .requestPermission(permission: Permission.notification);

                if (!hasPermission) return;

                await LocalNotificationHelper.instance.scheduleNotification(
                  title: 'Scheduled',
                  body: 'This is a scheduled notification',
                  scheduledDate: DateTime.now().add(const Duration(seconds: 5)),
                );
              },
              child: const Text('Scheduled Notification'),
            ),
            const SizedBox(height: UISpacing.space1x),
            FilledButton(
              style: buttonsProvider.primaryFilled,
              onPressed: () async {
                final hasPermission = await PermissionHelper.instance
                    .requestPermission(permission: Permission.notification);

                if (!hasPermission) return;

                await LocalNotificationHelper.instance.showNotification(
                  title: 'Hello',
                  body: 'This is a notification',
                );
              },
              child: const Text('Send Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
