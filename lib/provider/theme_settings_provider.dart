import 'package:flutter/material.dart';
import 'package:foodie/data/datasource/theme_preferences_service.dart';
import 'package:foodie/screens/state/theme_settings_state.dart';
import 'package:foodie/theme.dart';

class ThemeSettingsProvider with ChangeNotifier {
  final ThemePreferencesService _themePreferencesService;
  ThemeSettingsProvider(this._themePreferencesService);
  ThemeSettingsState _themeData = ThemeSettingsInitial();
  ThemeSettingsState get themeData => _themeData;

  void getTheme(TextTheme textTheme) async {
    final isDarkMode = await _themePreferencesService.readSettings();
    _themeData = ThemeSettingsLoading();
    notifyListeners();
    if (isDarkMode != null) {
      if (isDarkMode as bool) {
        _themeData = ThemeSettingsSuccess(theme: FoodieTheme(textTheme).dark(), darkTheme: FoodieTheme(textTheme).dark());
      } else {
        _themeData = ThemeSettingsSuccess(theme: FoodieTheme(textTheme).light(), darkTheme: FoodieTheme(textTheme).dark());
      }
    } else {
      _themeData = ThemeSettingsSuccess(theme: FoodieTheme(textTheme).light(), darkTheme: FoodieTheme(textTheme).dark());
    }
    notifyListeners();
  }

  Future<void> setDarkMode(TextTheme textTheme) async {
    _themeData = ThemeSettingsSuccess(theme: FoodieTheme(textTheme).dark(), darkTheme: FoodieTheme(textTheme).dark());
    await _themePreferencesService.saveSettings(true);
    notifyListeners();
  }

  Future<void> setLightMode(TextTheme textTheme) async {
    _themeData = ThemeSettingsSuccess(theme: FoodieTheme(textTheme).light(), darkTheme: FoodieTheme(textTheme).dark());
    await _themePreferencesService.saveSettings(false);
    notifyListeners();
  }
}
