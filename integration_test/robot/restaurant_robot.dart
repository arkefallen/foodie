import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class SettingsRobot {
  final WidgetTester tester;

  const SettingsRobot(this.tester);

  final iconSettingsKey = const ValueKey("icon_settings");
  final themeSettingsKey = const ValueKey("theme_title");

  Future<void> loadUi(Widget widget) async {
    await tester.pumpWidget(widget);
  }

  Future<void> goToSettings() async {
    final settingsButtonFinder = find.byKey(iconSettingsKey);
    await tester.tap(settingsButtonFinder);
    await tester.pumpAndSettle();
  }

  Future<void> verifyThemeSettings() async {
    final themeTitleFinder = find.byKey(themeSettingsKey);
    final themeTitle = tester.widget<Text>(themeTitleFinder);
    expect(themeTitle.data.toString(), "Mode Gelap");
  }
}
