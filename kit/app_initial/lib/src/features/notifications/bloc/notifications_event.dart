sealed class NotificationsEvent {}

class LoadNextNotificationPage extends NotificationsEvent {
  LoadNextNotificationPage({
    this.isRefresh = false,
  });

  final bool isRefresh;
}

class MarkNotificationAsRead extends NotificationsEvent {
  MarkNotificationAsRead({
    required this.notificationId,
  });

  final String notificationId;
}

class MarkAllNotificationsAsRead extends NotificationsEvent {
  MarkAllNotificationsAsRead();
}
