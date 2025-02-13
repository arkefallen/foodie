// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:foodie/data/datasource/local_database_service.dart';
import 'package:foodie/data/datasource/notification_service.dart';
import 'package:foodie/data/datasource/reminder_preferences_service.dart';
import 'package:foodie/data/datasource/restaurant_service.dart';
import 'package:foodie/data/datasource/theme_preferences_service.dart';
import 'package:foodie/data/datasource/worker_service.dart';
import 'package:foodie/provider/add_review_provider.dart';
import 'package:foodie/provider/bottom_navigation_provider.dart';
import 'package:foodie/provider/daily_reminder_provider.dart';
import 'package:foodie/provider/detail_restaurant_provider.dart';
import 'package:foodie/provider/favorite_restaurant_provider.dart';
import 'package:foodie/provider/list_restaurant_provider.dart';
import 'package:foodie/provider/search_restaurants_provider.dart';
import 'package:foodie/provider/settings_provider.dart';
import 'package:foodie/provider/theme_settings_provider.dart';
import 'package:foodie/screens/detail_restaurant_screen.dart';
import 'package:foodie/screens/favorite_restaurant_screen.dart';
import 'package:foodie/screens/home_screen.dart';
import 'package:foodie/screens/restaurant_screen.dart';
import 'package:foodie/screens/search_restaurant_screen.dart';
import 'package:foodie/screens/settings_screen.dart';
import 'package:foodie/screens/state/theme_settings_state.dart';
import 'package:provider/provider.dart';
import 'util.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider(
        create: (_) => NotificationService()..init(),
      ),
      Provider(create: (_) => RestaurantService()),
      Provider(create: (_) => LocalDatabaseService()),
      Provider(
        create: (context) => WorkManagerService()..init(),
      ),
      Provider(
        create: (_) => ReminderPreferencesService(),
      ),
      Provider(create: (_) => ThemePreferencesService()),
      ChangeNotifierProvider(
          create: (_) =>
              ListRestaurantProvider(restaurantService: RestaurantService())),
      ChangeNotifierProvider(
          create: (context) =>
              DetailRestaurantProvider(context.read<RestaurantService>())),
      ChangeNotifierProvider(
          create: (context) =>
              AddReviewProvider(context.read<RestaurantService>())),
      ChangeNotifierProvider(
          create: (context) =>
              SearchRestaurantsProvider(context.read<RestaurantService>())),
      ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
      ChangeNotifierProvider(
          create: (context) =>
              FavoriteRestaurantProvider(context.read<LocalDatabaseService>())),
      ChangeNotifierProvider(create: (context) => ThemeSettingsProvider(context.read<ThemePreferencesService>())),
      ChangeNotifierProvider(
          create: (context) =>
              SettingsProvider(context.read<ReminderPreferencesService>())),
      ChangeNotifierProvider(
        create: (context) => DailyReminderProvider(
          context.read<NotificationService>(),
          context.read<WorkManagerService>(),
        ),
      ),
    ],
    child: const FoodieApp(),
  ));
}

class FoodieApp extends StatefulWidget {
  const FoodieApp({super.key});

  @override
  State<FoodieApp> createState() => _FoodieAppState();
}

class _FoodieAppState extends State<FoodieApp> {

  @override
  void initState() {
    super.initState();
    TextTheme textTheme = createTextTheme(context, "Manrope", "Merriweather");
    Future.microtask(() {
      context.read<ThemeSettingsProvider>().getTheme(textTheme);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeSettingsProvider>(
      builder: (context, provider, _) {
        if (provider.themeData is ThemeSettingsSuccess) {
          final state = provider.themeData as ThemeSettingsSuccess;
          return MaterialApp(
            title: 'Foodie',
            theme: state.theme,
            darkTheme: state.darkTheme,
            home: const HomeScreen(),
            routes: {
              '/home': (context) => const HomeScreen(),
              '/detail': (context) {
                final restaurantId =
                ModalRoute.of(context)!.settings.arguments as String;
                return DetailRestaurantScreen(restaurantId: restaurantId);
              },
              '/restaurant': (context) => const RestaurantScreen(),
              '/favorite': (context) => const FavoriteRestaurantScreen(),
              '/search': (context) => const SearchRestaurantScreen(),
              '/settings': (context) => const SettingsScreen(),
            },
          );
        } else if (provider.themeData is ThemeSettingsError) {
          final state = provider.themeData as ThemeSettingsError;
          return Center(child: Text(state.error));
        }
        return const CircularProgressIndicator();
      }
    );
  }
}
