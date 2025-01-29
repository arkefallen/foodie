import 'dart:convert';

import 'package:foodie/data/model/restaurant_model.dart';

class DetailRestaurant {
  final bool error;
  final String message;
  final Restaurant restaurant;

  DetailRestaurant({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory DetailRestaurant.fromRawJson(String str) =>
      DetailRestaurant.fromJson(json.decode(str));

  factory DetailRestaurant.fromJson(Map<String, dynamic> json) =>
      DetailRestaurant(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.fromJson(json["restaurant"]),
      );
}
