import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationConfig {
  final FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    notificationPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();

    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('flutter_logo');

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    notificationPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {},
    );
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            icon: "flutter_logo"));
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    return notificationPlugin.show(id, title, body, notificationDetails());
  }
}
