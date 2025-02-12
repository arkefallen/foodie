import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodie/main.dart';
import 'package:foodie/provider/favorite_restaurant_provider.dart';
import 'package:foodie/provider/list_restaurant_provider.dart';
import 'package:foodie/provider/theme_settings_provider.dart';
import 'package:foodie/screens/restaurant_screen.dart';
import 'package:foodie/screens/state/list_favorite_restaurants_state.dart';
import 'package:foodie/screens/state/list_restaurant_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import 'mocks.dart';

void main() {
  late MockFavoriteRestaurantProvider favoriteRestaurantProvider;
  late MockListRestaurantProvider listRestaurantProvider;
  late Widget widget;

  setUp(() {
    listRestaurantProvider = MockListRestaurantProvider();
    favoriteRestaurantProvider = MockFavoriteRestaurantProvider();

    widget = MultiProvider(
      providers: [
        ChangeNotifierProvider<ListRestaurantProvider>(
          create: (_) => listRestaurantProvider,
        ),
        ChangeNotifierProvider<FavoriteRestaurantProvider>(
          create: (_) => favoriteRestaurantProvider,
        ),
      ],
      child: const MaterialApp(
        home: RestaurantScreen(),
      ),
    );
  });

  // Fix Widget Test
  group("List Restaurant Widget Test", () {
    testWidgets(
        "When RestaurantScreen() and ListRestaurantProvider loaded, it displays the loading component",
        (tester) async {
      when(() => listRestaurantProvider.state)
          .thenReturn(ListRestaurantLoading());
      when(() => favoriteRestaurantProvider.restaurantState)
          .thenReturn(ListFavoriteRestaurantLoading());

      await tester.pumpWidget(widget);

      await listRestaurantProvider.fetchListRestaurants();

      final loadingProgressBar = find.byType(CircularProgressIndicator);

      expect(loadingProgressBar, findsOneWidget);
    });
  });
}
