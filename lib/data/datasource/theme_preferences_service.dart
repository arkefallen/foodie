import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferencesService {
  static const String _darkModeKey = 'dark_mode';

  Future<void> saveSettings(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_darkModeKey, value);
  }

  Future<dynamic> readSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(_darkModeKey);
  }
}
