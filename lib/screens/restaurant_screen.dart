// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:foodie/provider/list_restaurant_provider.dart';
import 'package:foodie/screens/state/list_restaurant_state.dart';
import 'package:foodie/screens/widget/restaurant_item.dart';
import 'package:provider/provider.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ListRestaurantProvider>().fetchListRestaurants();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text(
            "Foodie",
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          )),
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
}
