import 'package:flutter/material.dart';
import 'package:foodie/data/datasource/theme_preferences_service.dart';
import 'package:foodie/theme.dart';

class ThemeSettingsProvider with ChangeNotifier {
  ThemeData _themeData = ThemeData.light(useMaterial3: true).copyWith(
    colorScheme: FoodieTheme.lightScheme(),
  );
  ThemeData getTheme(TextTheme textTheme) =>
      _themeData.copyWith(textTheme: textTheme);

  void setDarkMode(TextTheme textTheme) async {
    _themeData = FoodieTheme(textTheme).dark();
    ThemePreferencesService.saveSettings(true);
    notifyListeners();
  }

  void setLightMode(TextTheme textTheme) async {
    _themeData = FoodieTheme(textTheme).light();
    ThemePreferencesService.saveSettings(false);
    notifyListeners();
  }
}
