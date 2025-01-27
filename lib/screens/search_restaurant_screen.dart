import 'package:flutter/material.dart';
import 'package:foodie/screens/state/search_restaurant_state.dart';
import 'package:foodie/screens/widget/restaurant_item.dart';
import 'package:provider/provider.dart';
import 'package:foodie/provider/search_restaurants_provider.dart';

class SearchRestaurantScreen extends StatefulWidget {
  const SearchRestaurantScreen({super.key});

  @override
  State<SearchRestaurantScreen> createState() => _SearchRestaurantScreenState();
}

class _SearchRestaurantScreenState extends State<SearchRestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari Resto'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextField(
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                decoration: InputDecoration(
                  hintText: 'Ketikkan nama restoran favoritmu..',
                  border: const OutlineInputBorder(),
                  suffixIcon: const Icon(Icons.search),
                  hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
                onSubmitted: (query) {
                  context
                      .read<SearchRestaurantsProvider>()
                      .searchRestaurants(query);
                },
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Expanded(
              child: Consumer<SearchRestaurantsProvider>(
                builder: (context, provider, child) {
                  final state = provider.state;
                  if (state is SearchRestaurantLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchRestaurantError) {
                    final errorMsg = state.error;
                    return Center(child: Text(errorMsg));
                  } else if (state is SearchRestaurantSuccess) {
                    final restaurants = state.restaurant;
                    if (restaurants.isNotEmpty) {
                      return ListView.builder(
                        itemCount: restaurants.length,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              '/detail',
                              arguments: restaurants[index].id,
                            );
                          },
                          child: RestaurantItem(restaurant: restaurants[index]),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text('Tidak ada restoran yang ditemukan'),
                      );
                    }
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
