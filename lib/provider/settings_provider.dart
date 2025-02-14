import 'package:flutter/material.dart';
import 'package:foodie/data/datasource/reminder_preferences_service.dart';

class SettingsProvider with ChangeNotifier {
  final ReminderPreferencesService _reminderPreferencesService;

  SettingsProvider(this._reminderPreferencesService);

  bool _isDarkMode = false;
  bool _dailyReminder = false;

  bool get isDarkMode => _isDarkMode;
  bool get dailyReminder => _dailyReminder;

  void toggleDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  void toggleDailyReminder(bool value) {
    _dailyReminder = value;
    _reminderPreferencesService.saveSettings(value);
    notifyListeners();
  }

  void loadSettings() async {
    _dailyReminder = await _reminderPreferencesService.readSettings();
    notifyListeners();
  }
}
