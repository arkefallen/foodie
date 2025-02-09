// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:foodie/provider/favorite_restaurant_provider.dart';
import 'package:foodie/provider/list_restaurant_provider.dart';
import 'package:foodie/provider/theme_settings_provider.dart';
import 'package:foodie/screens/state/list_restaurant_state.dart';
import 'package:foodie/screens/widget/restaurant_item.dart';
import 'package:foodie/util.dart';
import 'package:provider/provider.dart';

enum ThemeSettings { light, dark }

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  late ThemeSettings groupValue;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ListRestaurantProvider>().fetchListRestaurants();
      context.read<FavoriteRestaurantProvider>().loadFavoriteRestaurant();
      TextTheme textTheme = createTextTheme(context, "Manrope", "Merriweather");
      final currentTheme = context.read<ThemeSettingsProvider>().getTheme(textTheme);
      if (currentTheme.brightness == Brightness.dark) {
        groupValue = ThemeSettings.dark;
      } else {
        groupValue = ThemeSettings.light;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Manrope", "Merriweather");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          "Foodie",
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showChangeThemeButton(context, textTheme);
            },
            icon: const Icon(Icons.contrast),
          ),
        ],
      ),
      body: Consumer<ListRestaurantProvider>(
        builder: (context, provider, _) {
          final state = provider.state;
          if (state is ListRestaurantLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ListRestaurantSuccess) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                itemCount: state.restaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = state.restaurants[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/detail',
                        arguments: restaurant.id,
                      );
                    },
                    child: RestaurantItem(restaurant: restaurant),
                  );
                },
              ),
            );
          } else if (state is ListRestaurantError) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(state.error),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Future<dynamic> showChangeThemeButton(
      BuildContext context, TextTheme textTheme) {
    return showAdaptiveDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Ubah Tema",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Tutup"),
              ),
            ],
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile.adaptive(
                  title: const Text("Cerah"),
                  value: ThemeSettings.light,
                  groupValue: groupValue,
                  onChanged: (_) {
                    context
                        .read<ThemeSettingsProvider>()
                        .setLightMode(textTheme);
                    setState(() {
                      groupValue = ThemeSettings.light;
                    });
                  },
                ),
                RadioListTile.adaptive(
                  title: const Text("Gelap"),
                  value: ThemeSettings.dark,
                  groupValue: groupValue,
                  onChanged: (_) {
                    context
                        .read<ThemeSettingsProvider>()
                        .setDarkMode(textTheme);
                    setState(() {
                      groupValue = ThemeSettings.dark;
                    });
                  },
                ),
              ],
            ),
          );
        });
  }
}
