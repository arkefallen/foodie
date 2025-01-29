import 'package:flutter/material.dart';

class RestaurantRating extends StatelessWidget {
  final String rating;

  const RestaurantRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.star_rounded,
          color: Colors.amber,
        ),
        Text(rating,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                )),
      ],
    );
  }
}
