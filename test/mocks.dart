import 'package:foodie/data/datasource/reminder_preferences_service.dart';
import 'package:foodie/data/datasource/restaurant_service.dart';
import 'package:foodie/data/datasource/theme_preferences_service.dart';
import 'package:foodie/provider/daily_reminder_provider.dart';
import 'package:foodie/provider/favorite_restaurant_provider.dart';
import 'package:foodie/provider/list_restaurant_provider.dart';
import 'package:foodie/provider/settings_provider.dart';
import 'package:foodie/provider/theme_settings_provider.dart';
import 'package:mocktail/mocktail.dart';

class MockRestaurantService extends Mock implements RestaurantService {}

class MockListRestaurantProvider extends Mock
    implements ListRestaurantProvider {
  @override
  Future<void> fetchListRestaurants() async {}
}

class MockFavoriteRestaurantProvider extends Mock
    implements FavoriteRestaurantProvider {
  @override
  Future<void> loadFavoriteRestaurant() async {}
}

class MockThemeSettingsProvider extends Mock implements ThemeSettingsProvider {}

class MockSettingsProvider extends Mock implements SettingsProvider {}

class MockDailyReminderProvider extends Mock implements DailyReminderProvider {}

class MockReminderPreferenceService extends Mock implements ReminderPreferencesService {}

class MockThemePreferenceService extends Mock implements ThemePreferencesService {}
