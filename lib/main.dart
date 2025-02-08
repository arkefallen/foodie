import 'package:flutter/material.dart';
import 'package:foodie/data/datasource/restaurant_service.dart';
import 'package:foodie/provider/add_review_provider.dart';
import 'package:foodie/provider/bottom_navigation_provider.dart';
import 'package:foodie/provider/detail_restaurant_provider.dart';
import 'package:foodie/provider/favorite_restaurant_provider.dart';
import 'package:foodie/provider/list_restaurant_provider.dart';
import 'package:foodie/provider/search_restaurants_provider.dart';
import 'package:foodie/screens/detail_restaurant_screen.dart';
import 'package:foodie/screens/home_screen.dart';
import 'package:foodie/screens/restaurant_screen.dart';
import 'package:foodie/theme.dart';
import 'package:provider/provider.dart';
import 'util.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) =>
              ListRestaurantProvider(restaurantService: RestaurantService())),
      ChangeNotifierProvider(create: (_) => DetailRestaurantProvider()),
      ChangeNotifierProvider(create: (_) => AddReviewProvider()),
      ChangeNotifierProvider(create: (_) => SearchRestaurantsProvider()),
      ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
      ChangeNotifierProvider(create: (_) => FavoriteRestaurantProvider()),
    ],
    child: const FoodieApp(),
  ));
}

class FoodieApp extends StatelessWidget {
  const FoodieApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Manrope", "Merriweather");
    return MaterialApp(
      title: 'Foodie',
      theme: FoodieTheme(textTheme).light(),
      darkTheme: FoodieTheme(textTheme).dark(),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/detail': (context) {
          final restaurantId =
              ModalRoute.of(context)!.settings.arguments as String;
          return DetailRestaurantScreen(restaurantId: restaurantId);
        },
        '/restaurant': (context) => const RestaurantScreen(),
      },
    );
  }
}
