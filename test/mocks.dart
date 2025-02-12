import 'package:flutter/src/material/text_theme.dart';
import 'package:flutter/src/material/theme_data.dart';
import 'package:foodie/data/datasource/restaurant_service.dart';
import 'package:foodie/provider/favorite_restaurant_provider.dart';
import 'package:foodie/provider/list_restaurant_provider.dart';
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

class MockThemeSettingsProvider extends Mock implements ThemeSettingsProvider {
  @override
  ThemeData getTheme(TextTheme textTheme) => ThemeData.light();
}
