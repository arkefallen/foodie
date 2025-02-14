import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodie/provider/daily_reminder_provider.dart';
import 'package:foodie/provider/favorite_restaurant_provider.dart';
import 'package:foodie/provider/list_restaurant_provider.dart';
import 'package:foodie/provider/settings_provider.dart';
import 'package:foodie/provider/theme_settings_provider.dart';
import 'package:foodie/screens/restaurant_screen.dart';
import 'package:foodie/screens/settings_screen.dart';
import 'package:foodie/screens/state/list_favorite_restaurants_state.dart';
import 'package:foodie/screens/state/list_restaurant_state.dart';
import 'package:foodie/screens/state/theme_settings_state.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../test/mocks.dart';
import 'robot/restaurant_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockFavoriteRestaurantProvider favoriteRestaurantProvider;
  late MockListRestaurantProvider listRestaurantProvider;
  late MockSettingsProvider settingsProvider;
  late MockThemeSettingsProvider themeSettingsProvider;
  late MockDailyReminderProvider dailyReminderProvider;
  late MockReminderPreferenceService reminderPreferenceService;
  late MockThemePreferenceService themePreferenceService;
  late Widget widget;

  setUp(() {
    listRestaurantProvider = MockListRestaurantProvider();
    favoriteRestaurantProvider = MockFavoriteRestaurantProvider();
    settingsProvider = MockSettingsProvider();
    themeSettingsProvider = MockThemeSettingsProvider();
    dailyReminderProvider = MockDailyReminderProvider();
    reminderPreferenceService = MockReminderPreferenceService();
    themePreferenceService = MockThemePreferenceService();

    when(() => listRestaurantProvider.state)
        .thenReturn(ListRestaurantLoading());
    when(() => favoriteRestaurantProvider.restaurantState)
        .thenReturn(ListFavoriteRestaurantLoading());
    when(() => themePreferenceService.readSettings())
        .thenAnswer((_) => Future.value(true));
    when(() => reminderPreferenceService.readSettings())
        .thenAnswer((_) => Future.value(true));
    when(() => settingsProvider.isDarkMode).thenReturn(true);
    when(() => settingsProvider.dailyReminder).thenReturn(true);
    when(() => themeSettingsProvider.themeData).thenReturn(ThemeSettingsSuccess(
        theme: ThemeData.light(), darkTheme: ThemeData.dark()));

    widget = MultiProvider(
      providers: [
        ChangeNotifierProvider<ListRestaurantProvider>(
          create: (_) => listRestaurantProvider,
        ),
        ChangeNotifierProvider<FavoriteRestaurantProvider>(
          create: (_) => favoriteRestaurantProvider,
        ),
        ChangeNotifierProvider<SettingsProvider>(
          create: (_) => settingsProvider,
        ),
        ChangeNotifierProvider<ThemeSettingsProvider>(
          create: (_) => themeSettingsProvider,
        ),
        ChangeNotifierProvider<DailyReminderProvider>(
          create: (_) => dailyReminderProvider,
        ),
        Provider(create: (_) => reminderPreferenceService),
        Provider(create: (_) => themePreferenceService),
      ],
      child: MaterialApp(
        home: const RestaurantScreen(),
        routes: {'/settings': (context) => const SettingsScreen()},
      ),
    );
  });

  testWidgets(
      "When Settings Button in RestaurantScreen() is tapped, the SettingsScreen() should display theme settings",
      (tester) async {
    final robot = SettingsRobot(tester);

    await robot.loadUi(widget);

    await robot.goToSettings();

    await robot.verifyThemeSettings();
  });
}
