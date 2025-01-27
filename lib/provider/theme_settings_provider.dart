import 'package:flutter/material.dart';
import 'package:foodie/theme.dart';

class ThemeSettingsProvider with ChangeNotifier {
  ThemeData _themeData = ThemeData.light(useMaterial3: true).copyWith(
    colorScheme: MaterialTheme.lightScheme(),
  );
  ThemeData getTheme(TextTheme textTheme) =>
      _themeData.copyWith(textTheme: textTheme);

  void setDarkMode(TextTheme textTheme) async {
    _themeData = MaterialTheme(textTheme).dark();
    notifyListeners();
  }

  void setLightMode(TextTheme textTheme) async {
    _themeData = MaterialTheme(textTheme).light();
    notifyListeners();
  }
}
