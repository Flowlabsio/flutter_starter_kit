import 'package:app_initial/src/datasources/notification/notification.dart';
import 'package:app_initial/src/helpers/helpers.dart';
import 'package:app_initial/src/models/models.dart';
import 'package:app_initial/src/repositories/notification/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  NotificationRepositoryImpl({required this.notificationDatasource});

  final NotificationDatasource notificationDatasource;

  @override
  Future<List<Notification>> getNotifications({
    required String userId,
    int limit = 20,
    PagePointer? page,
  }) {
    return notificationDatasource.getNotifications(
      userId: userId,
      limit: limit,
      page: page,
    );
  }

  @override
  Future<void> markAsRead({
    required String userId,
    required String notificationId,
  }) {
    return notificationDatasource.markAsRead(
      userId: userId,
      notificationId: notificationId,
    );
  }

  @override
  Future<void> markAllAsRead({
    required String userId,
  }) {
    return notificationDatasource.markAllAsRead(userId: userId);
  }

  @override
  Future<void> deleteNotification({
    required String userId,
    required String notificationId,
  }) {
    return notificationDatasource.deleteNotification(
      userId: userId,
      notificationId: notificationId,
    );
  }

  @override
  Future<void> deleteAllNotifications({
    required String userId,
  }) {
    return notificationDatasource.deleteAllNotifications(userId: userId);
  }

  @override
  Future<int> unreadNotification({
    required String userId,
  }) {
    return notificationDatasource.unreadNotification(userId: userId);
  }
}
