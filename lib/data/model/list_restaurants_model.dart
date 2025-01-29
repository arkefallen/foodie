import 'dart:convert';

import 'package:foodie/data/model/restaurant_model.dart';

class ListRestaurants {
  final bool? error;
  final String? message;
  final int? count;
  final List<Restaurant>? restaurants;

  ListRestaurants({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory ListRestaurants.fromRawJson(String str) =>
      ListRestaurants.fromJson(json.decode(str));

  factory ListRestaurants.fromJson(Map<String, dynamic> json) =>
      ListRestaurants(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(json["restaurants"]
            ?.map((x) => Restaurant.fromJsonListRestaurant(x))),
      );
}
