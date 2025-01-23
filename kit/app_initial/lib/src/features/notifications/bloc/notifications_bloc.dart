import 'package:app_helpers/app_helpers.dart';
import 'package:app_initial/src/facades/facades.dart';
import 'package:app_initial/src/features/notifications/bloc/bloc.dart';
import 'package:app_initial/src/helpers/helpers.dart';
import 'package:app_initial/src/repositories/notification/notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc({
    required this.notificationRepository,
  }) : super(NotificationsState.initial(isLoadingNextPage: true)) {
    on<LoadNextNotificationPage>(_onLoadNextNotificationPage);
    on<MarkNotificationAsRead>(_onMarkNotificationAsRead);
    on<MarkAllNotificationsAsRead>(_onMarkAllNotificationsAsRead);
  }

  final NotificationRepository notificationRepository;

  Future<void> _onLoadNextNotificationPage(
    LoadNextNotificationPage event,
    Emitter<NotificationsState> emit,
  ) async {
    if (!event.isRefresh) {
      if (state.isLoadingNextPage) return;

      if (!state.hasNextPage) {
        return;
      }
    } else {
      emit(
        state.copyWith(hasNextPage: true, isRefreshing: true)
          ..pointerLastDocument = null,
      );
    }

    emit(state.copyWith(isLoadingNextPage: true));

    try {
      final userId = Auth.instance.id()!;
      const limit = 10;
      final lastDocument = state.pointerLastDocument;
      final notifications = state.notifications;

      final newNotifications = await notificationRepository.getNotifications(
        userId: userId,
        page: lastDocument != null ? PagePointer(lastDocument) : null,
        limit: limit,
      );

      if (newNotifications.length < limit) {
        emit(state.copyWith(hasNextPage: false));
      } else {
        final pointer = Timestamp.fromDate(newNotifications.last.createdAt);

        emit(state.copyWith(pointerLastDocument: pointer));
      }

      emit(
        state.copyWith(
          notifications: [
            if (!event.isRefresh) ...notifications,
            ...newNotifications,
          ],
        ),
      );
    } catch (e, s) {
      CustomSnackbar.instance.error(
        text: Localization.instance.tr.generalError,
      );

      AppLogger.error(e.toString(), stackTrace: s);
    } finally {
      emit(state.copyWith(isLoadingNextPage: false, isRefreshing: false));
    }
  }

  Future<void> _onMarkNotificationAsRead(
    MarkNotificationAsRead event,
    Emitter<NotificationsState> emit,
  ) async {
    final userId = Auth.instance.id()!;

    final notifications = state.notifications;
    final index = notifications.indexWhere(
      (element) => element.id == event.notificationId,
    );

    if (index == -1) return;

    try {
      emit(
        state.copyWith(
          notifications: notifications.map((notification) {
            if (notification.id == event.notificationId) {
              return notification.copyWith(wasRead: true);
            }

            return notification;
          }).toList(),
        ),
      );

      await notificationRepository.markAsRead(
        userId: userId,
        notificationId: event.notificationId,
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          notifications: notifications.map((notification) {
            if (notification.id == event.notificationId) {
              return notification.copyWith(wasRead: false);
            }

            return notification;
          }).toList(),
        ),
      );

      CustomSnackbar.instance.error(
        text: Localization.instance.tr.generalError,
      );

      AppLogger.error(e.toString(), stackTrace: s);
    }
  }

  Future<void> _onMarkAllNotificationsAsRead(
    MarkAllNotificationsAsRead event,
    Emitter<NotificationsState> emit,
  ) async {
    final userId = Auth.instance.id()!;

    final notifications = state.notifications;

    final noReadNotificationIds = notifications
        .where((element) {
          return !element.wasRead;
        })
        .map((e) => e.id)
        .toList();

    try {
      emit(
        state.copyWith(
          notifications: notifications.map((notification) {
            return notification.copyWith(wasRead: true);
          }).toList(),
        ),
      );

      await notificationRepository.markAllAsRead(userId: userId);
    } catch (e, s) {
      emit(
        state.copyWith(
          notifications: notifications.map((notification) {
            if (noReadNotificationIds.contains(notification.id)) {
              return notification.copyWith(wasRead: false);
            }
            return notification;
          }).toList(),
        ),
      );

      CustomSnackbar.instance.error(
        text: Localization.instance.tr.generalError,
      );

      AppLogger.error(e.toString(), stackTrace: s);
    }
  }
}
