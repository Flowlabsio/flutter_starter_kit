import 'package:app_initial/src/helpers/helpers.dart';
import 'package:app_initial/src/models/models.dart';

abstract class NotificationDatasource {
  Future<List<Notification>> getNotifications({
    required String userId,
    int limit = 20,
    PagePointer? page,
  });
  Future<void> markAsRead({
    required String userId,
    required String notificationId,
  });

  Future<void> markAllAsRead({
    required String userId,
  });

  Future<void> deleteNotification({
    required String userId,
    required String notificationId,
  });

  Future<void> deleteAllNotifications({
    required String userId,
  });

  Future<int> unreadNotification({
    required String userId,
  });
}
