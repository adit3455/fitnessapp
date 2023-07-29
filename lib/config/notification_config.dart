import 'package:fitness_app/repository/isar_repo/isar_set_reminder.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:fitness_app/extension/extension.dart';

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

  Future<void> showNotification(
          {int id = 0, String? title, String? body, String? payload}) async =>
      await notificationPlugin.show(id, title, body, notificationDetails());

  Future<void> showScheduledNotification(
          {required int id,
          String? title,
          String? body,
          String? payload,
          required DateTime scheduledNotificationDateTime}) async =>
      await notificationPlugin.zonedSchedule(
          id,
          title ?? "Fitness App",
          body ?? "Good Health comes from daily exercises!",
          tz.TZDateTime.from(scheduledNotificationDateTime, tz.local),
          notificationDetails(),
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);

  Future<void> scheduledDaily() async {
    final lPendingNotif =
        await notificationPlugin.pendingNotificationRequests();

    final isarData = await IsarSetReminder().getAllIsar();
    final lMonth = getMonth(DateTime.now().add(const Duration(days: 1)));

    int date(DateTime d) => int.parse(DateFormat.d().format(d));
    int month(DateTime d) => int.parse(DateFormat.M().format(d));
    int year(DateTime d) => int.parse(DateFormat.y().format(d));

    if (isarData.isEmpty && lPendingNotif.isEmpty) {
      for (int i = 0; i < lMonth.length; i++) {
        await showScheduledNotification(
            id: i,
            scheduledNotificationDateTime: DateTime(
                year(lMonth[i]), month(lMonth[i]), date(lMonth[i]), 6, 0));
      }
      if (isarData.isEmpty && lPendingNotif.isNotEmpty) {
        await notificationPlugin.cancelAll();
        for (int i = 0; i < lMonth.length; i++) {
          await showScheduledNotification(
              id: i,
              scheduledNotificationDateTime: DateTime(
                  year(lMonth[i]), month(lMonth[i]), date(lMonth[i]), 6, 0));
        }
      }
      if (isarData.isNotEmpty && lPendingNotif.isNotEmpty) {
        await notificationPlugin.cancelAll();
        final isarDate = isarData.firstWhere((element) => element.id == 1);
        final reminderDateTime = DateTime.parse(isarDate.duration);
        final lMonthIsar = getMonth(reminderDateTime);
        for (int i = 0; i < lMonthIsar.length; i++) {
          await showScheduledNotification(
              id: i,
              scheduledNotificationDateTime: DateTime(
                  year(lMonthIsar[i]),
                  month(lMonthIsar[i]),
                  date(lMonthIsar[i]),
                  reminderDateTime.hour,
                  reminderDateTime.minute,
                  reminderDateTime.second));
        }
      }
    }
  }

  Future<List<PendingNotificationRequest>> getAllNotif() async =>
      await notificationPlugin.pendingNotificationRequests();

  Future<void> deleteAllNotif() async => await notificationPlugin.cancelAll();

  DateTime durationToDateTime(String duration) {
    final d = duration.parseDuration();
    String strDigits(int n) => n.toString().padLeft(2, '0');

    final hours = int.parse(strDigits(d.inHours.remainder(24)));
    final minutes = int.parse(strDigits(d.inMinutes.remainder(60)));
    final seconds = int.parse(strDigits(d.inSeconds.remainder(60)));
    final date = int.parse(DateFormat.d().format(DateTime.now()));
    final month = int.parse(DateFormat.M().format(DateTime.now()));
    final year = int.parse(DateFormat.y().format(DateTime.now()));

    return DateTime(year, month, date, hours, minutes, seconds)
        .add(const Duration(days: 1));
  }

  List<DateTime> getMonth(DateTime today) {
    DateTime nextMonth = DateTime(today.year, today.month + 1, today.day);

    int daysDifference = nextMonth.difference(today).inDays;

    List<DateTime> dateRange = [];
    for (int i = 0; i <= daysDifference; i++) {
      dateRange.add(today.add(Duration(days: i)));
    }

    return dateRange;
  }
}
