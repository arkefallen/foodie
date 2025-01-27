import 'dart:convert';

import 'package:foodie/data/model/restaurant_model.dart';

class SearchRestaurant {
    final bool error;
    final int founded;
    final List<Restaurant> restaurants;

    SearchRestaurant({
        required this.error,
        required this.founded,
        required this.restaurants,
    });

    factory SearchRestaurant.fromRawJson(String str) => SearchRestaurant.fromJson(json.decode(str));

    factory SearchRestaurant.fromJson(Map<String, dynamic> json) => SearchRestaurant(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJsonListRestaurant(x))),
    );
}