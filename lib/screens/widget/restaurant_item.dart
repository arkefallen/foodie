import 'package:flutter/material.dart';
import 'package:foodie/data/model/restaurant_images_enum.dart';
import 'package:foodie/data/model/restaurant_model.dart';
import 'package:foodie/provider/favorite_restaurant_provider.dart';
import 'package:foodie/screens/widget/restaurant_rating.dart';
import 'package:provider/provider.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantItem({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Hero(
        tag: restaurant.id.toString(),
        child: Card.filled(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      RestaurantImage.small
                          .getImageUrl(restaurant.pictureId.toString()),
                      width: double.infinity,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              restaurant.name.toString(),
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              "di ${restaurant.city.toString()}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                            ),
                            RestaurantRating(
                                rating: restaurant.rating.toString()),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: context
                              .watch<FavoriteRestaurantProvider>()
                              .isThisItemFavorite(restaurant.id.toString())
                          ? IconButton(
                              iconSize: 30.0,
                              onPressed: () {
                                context
                                    .read<FavoriteRestaurantProvider>()
                                    .removeRestaurant(restaurant);
                                context
                                    .read<FavoriteRestaurantProvider>()
                                    .loadFavoriteRestaurant();
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: Colors.red.shade400,
                              ))
                          : IconButton(
                              iconSize: 30.0,
                              onPressed: () {
                                context
                                    .read<FavoriteRestaurantProvider>()
                                    .addRestaurant(restaurant);
                                context
                                    .read<FavoriteRestaurantProvider>()
                                    .loadFavoriteRestaurant();
                              },
                              icon: const Icon(Icons.favorite_outline)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
