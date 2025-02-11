import 'package:shared_preferences/shared_preferences.dart';

class ReminderPreferencesService {
  static const String _reminderKey = 'daily_reminder';

  Future<void> saveSettings(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_reminderKey, value);
  }

  Future<dynamic> readSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(_reminderKey) ?? false;
  }
}
