import 'package:flutter/material.dart';
import 'package:foodie/provider/favorite_restaurant_provider.dart';
import 'package:foodie/screens/state/list_favorite_restaurants_state.dart';
import 'package:foodie/screens/widget/restaurant_item.dart';
import 'package:provider/provider.dart';

class FavoriteRestaurantScreen extends StatefulWidget {
  const FavoriteRestaurantScreen({super.key});

  @override
  State<FavoriteRestaurantScreen> createState() =>
      _FavoriteRestaurantScreenState();
}

class _FavoriteRestaurantScreenState extends State<FavoriteRestaurantScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      context.read<FavoriteRestaurantProvider>().loadFavoriteRestaurant();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resto Kesukaanmu'),
      ),
      body: Consumer<FavoriteRestaurantProvider>(
        builder: (context, provider, _) {
          final state = provider.restaurantState;
          if (state is ListFavoriteRestaurantLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ListFavoriteRestaurantSuccess) {
            if (state.restaurants.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text("Tidak ada data"),
                ),
              );
            } else {
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
            }
          } else if (state is ListFavoriteRestaurantError) {
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
}
