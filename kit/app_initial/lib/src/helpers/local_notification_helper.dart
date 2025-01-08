import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';

Future<void> onBackgroundMessage(RemoteMessage message) async {
  /// Handles messages received when the app is in the background or terminated.
  debugPrint('onBackgroundMessage');

  if (message.data.isNotEmpty) {
    /// Handle data messages.
  }
}

Future<void> onMessage(RemoteMessage message) async {
  if (message.notification?.title != null) {
    await LocalNotificationHelper.instance.showNotification(
      title: message.notification?.title,
      body: message.notification?.body,
    );
  }

  if (message.data.isNotEmpty) {
    /// Handle data messages.
  }
}

Future<void> onMessageOpenedApp(RemoteMessage message) async {
  if (message.data.isNotEmpty) {
    /// Handle data messages.
  }
}

class LocalNotificationHelper {
  LocalNotificationHelper._singleton();

  static final LocalNotificationHelper instance =
      LocalNotificationHelper._singleton();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const initializationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
    FirebaseMessaging.onMessage.listen(onMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpenedApp);
  }

  Future<String?> getToken() async {
    final token = await FirebaseMessaging.instance.getToken();

    return token;
  }

  Future<void> requestPermission() async {
    await FirebaseMessaging.instance.requestPermission();
  }

  Future<void> showNotification({
    required String? title,
    required String? body,
    int? id,
  }) async {
    const androidPlatformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        'standard',
        'Standard',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    final randomId = int.parse(
      DateTime.now().millisecondsSinceEpoch.toString().substring(0, 5),
    );

    await flutterLocalNotificationsPlugin.show(
      id ?? randomId,
      title,
      body,
      androidPlatformChannelSpecifics,
    );
  }

  Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledDate,
    int? id,
    String channelId = 'standard',
    String channelName = 'Standard',
    DateTimeComponents? matchDateTimeComponents =
        DateTimeComponents.dateAndTime,
    String? payload,
  }) async {
    final platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelName,
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: const DarwinNotificationDetails(),
    );

    final randomId = int.parse(
      DateTime.now().millisecondsSinceEpoch.toString().substring(0, 5),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id ?? randomId,
      title,
      body,
      TZDateTime.from(scheduledDate, local),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exact,
      matchDateTimeComponents: matchDateTimeComponents,
      payload: payload,
    );
  }

  Future<void> scheduleDailyNotification({
    required String title,
    required String body,
    required DateTime scheduledTime,
    int? id,
    String channelId = 'standard',
    String channelName = 'Standard',
    String? payload,
  }) async {
    var time = scheduledTime;
    if (scheduledTime.isBefore(DateTime.now())) {
      time = scheduledTime.add(const Duration(days: 1));
    }

    final tzTime = TZDateTime.from(time, local);

    await scheduleNotification(
      id: id,
      title: title,
      body: body,
      channelId: channelId,
      channelName: channelName,
      scheduledDate: tzTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: payload,
    );
  }

  Future<void> scheduleWeeklyNotification({
    required String title,
    required String body,
    required DateTime scheduledTime,
    int? id,
    String channelId = 'standard',
    String channelName = 'Standard',
    String? payload,
  }) async {
    var time = scheduledTime;

    if (scheduledTime.isBefore(DateTime.now())) {
      time = scheduledTime.add(const Duration(days: 7));
    }

    final tzTime = TZDateTime.from(time, local);

    await scheduleNotification(
      id: id,
      title: title,
      body: body,
      channelId: channelId,
      channelName: channelName,
      scheduledDate: tzTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      payload: payload,
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
