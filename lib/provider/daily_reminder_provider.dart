import 'package:flutter/material.dart';
import 'package:foodie/data/datasource/notification_service.dart';
import 'package:foodie/data/datasource/worker_service.dart';

class DailyReminderProvider extends ChangeNotifier {
  final NotificationService _notificationService;
  final WorkManagerService _workManagerService;

  DailyReminderProvider(this._notificationService, this._workManagerService);

  bool? _permission = false;
  bool? get permission => _permission;

  Future<void> scheduleDailyReminderNotificationEveryElevenAM() async {
    await _workManagerService.runPeriodicTask();
  }

  Future<void> cancelNotification() async {
    await _notificationService.cancelNotification();
    notifyListeners();
  }

  Future<void> requestPermission() async {
    _permission = await _notificationService.requestPermission();
    notifyListeners();
  }
}
