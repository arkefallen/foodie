import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsDarwin = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false);
    const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin);
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
    await configureLocalTimeZone();
  }

  Future<bool> _isAndroidPermissonGranted() async {
    return await _flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.areNotificationsEnabled() ??
        false;
  }

  Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  tz.TZDateTime _nextInstanceOfElevenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(now.location, now.year, now.month, now.day, 11);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<bool> _requestExactAlarmsPermission() async {
    return await _flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestExactAlarmsPermission() ??
        false;
  }

  Future<bool?> requestPermission() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final androidImplementation = _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      final requestNotificationPermission =
          await androidImplementation?.requestNotificationsPermission();
      final notificationEnabled = await _isAndroidPermissonGranted();
      final requestAlarmEnabled = await _requestExactAlarmsPermission();
      return (requestNotificationPermission ?? false) &&
          notificationEnabled &&
          requestAlarmEnabled;
    } else {
      return false;
    }
  }

  Future<void> scheduleDailyReminderOnElevenAM({
    String restaurantId = "",
    String channelId = "1",
    String channelName = "Daily Reminder Notification",
    String data = "Jangan lupa makan siang ya!",
  }) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    final notificationDetails = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    final dateTimeSchedule = _nextInstanceOfElevenAM();

    await _flutterLocalNotificationsPlugin.zonedSchedule(
        Random().nextInt(100),
        "Waktunya Makan Siang nih!",
        "Yuk cobain menu makan di resto $data. Dijamin enak!",
        dateTimeSchedule,
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: restaurantId);
  }

  Future<List<PendingNotificationRequest>> pendingNotificationRequest() async {
    final List<PendingNotificationRequest> pendingNotifReq =
        await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return pendingNotifReq;
  }

  Future<void> cancelNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
