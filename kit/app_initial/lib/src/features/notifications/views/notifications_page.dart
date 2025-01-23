import 'package:app_initial/l10n/l10n.dart';
import 'package:app_initial/src/features/notifications/bloc/bloc.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    final colors = Theme.of(context).colors;

    final notifications =
        context.select((NotificationsBloc bloc) => bloc.state.notifications);

    final isLoadingNextPage = context
        .select((NotificationsBloc bloc) => bloc.state.isLoadingNextPage);

    final hasNextPage =
        context.select((NotificationsBloc bloc) => bloc.state.hasNextPage);

    final isRefreshing =
        context.select((NotificationsBloc bloc) => bloc.state.isRefreshing);

    final showGlobalLoading = isLoadingNextPage && notifications.isEmpty;

    final showBottomLoader = isLoadingNextPage &&
        notifications.isNotEmpty &&
        !isRefreshing &&
        hasNextPage;

    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.notifications),
        actions: [
          PopupMenuButton(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(UISpacing.space10x),
            color: colors.surface,
            padding: EdgeInsets.zero,
            menuPadding: EdgeInsets.zero,
            icon: const Icon(Icons.more_vert_outlined),
            offset: const Offset(
              -UISpacing.space2x,
              UISpacing.space2x,
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem<void>(
                  child: Text(l10n.markAllAsRead),
                  onTap: () {
                    context.read<NotificationsBloc>().add(
                          MarkAllNotificationsAsRead(),
                        );
                  },
                ),
              ];
            },
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: showGlobalLoading
            ? const Center(
                child: CircularProgressIndicator(
                  strokeWidth: UISpacing.px2,
                ),
              )
            : notifications.isNotEmpty
                ? NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification onNotification) {
                      if (onNotification.metrics.extentAfter < 400) {
                        context
                            .read<NotificationsBloc>()
                            .add(LoadNextNotificationPage());
                      }
                      return true;
                    },
                    child: RefreshIndicator(
                      onRefresh: () async {
                        final bloc = context.read<NotificationsBloc>()
                          ..add(LoadNextNotificationPage(isRefresh: true));

                        await bloc.stream.firstWhere((state) {
                          return state.isRefreshing == true;
                        });

                        await bloc.stream.firstWhere((state) {
                          return state.isRefreshing == false;
                        });
                      },
                      child: ListView.builder(
                        padding: EdgeInsets.only(
                          bottom: bottomPadding,
                        ),
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount:
                            notifications.length + (showBottomLoader ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == notifications.length) {
                            return const Column(
                              children: [
                                SizedBox(height: UISpacing.space2x),
                                SizedBox(
                                  width: UISpacing.space6x,
                                  height: UISpacing.space6x,
                                  child: CircularProgressIndicator(
                                    strokeWidth: UISpacing.px2,
                                  ),
                                ),
                                SizedBox(height: UISpacing.space2x),
                              ],
                            );
                          }

                          final notification = notifications[index];

                          return ListTile(
                            title: Row(
                              children: [
                                if (!notification.wasRead)
                                  Container(
                                    width: UISpacing.space1x,
                                    height: UISpacing.space1x,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: colors.primary,
                                    ),
                                  ),
                                const SizedBox(width: UISpacing.space1x),
                                Text(notification.title),
                              ],
                            ),
                            subtitle: Text(notification.body),
                            onTap: () {
                              if (notification.wasRead) return;

                              context.read<NotificationsBloc>().add(
                                    MarkNotificationAsRead(
                                      notificationId: notification.id,
                                    ),
                                  );
                            },
                            trailing: Text(
                              DateFormat.yMMMEd()
                                  .format(notification.createdAt),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : Center(child: Text(l10n.noNotifications)),
      ),
    );
  }
}
