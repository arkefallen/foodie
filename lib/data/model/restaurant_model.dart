import 'dart:convert';

import 'package:foodie/data/model/customer_review_model.dart';
import 'package:foodie/data/model/menu_category.dart';
import 'package:foodie/data/model/menus_model.dart';

class Restaurant {
  final String? id;
  final String? name;
  final String? description;
  final String? city;
  final String? address;
  final String? pictureId;
  final List<RestaurantCategory>? categories;
  final Menus? menus;
  final double? rating;
  final List<CustomerReview>? customerReviews;

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.categories,
    this.menus,
    this.rating,
    this.customerReviews,
  });

  factory Restaurant.fromRawJson(String str) =>
      Restaurant.fromJson(json.decode(str));

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: List<RestaurantCategory>.from(
            json["categories"]?.map((x) => RestaurantCategory.fromJson(x))),
        menus: Menus.fromJson(json["menus"]),
        rating: json["rating"]?.toDouble(),
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"]?.map((x) => CustomerReview.fromJson(x))),
      );

  factory Restaurant.fromRawJsonListRestaurant(String str) =>
      Restaurant.fromJson(json.decode(str));

  factory Restaurant.fromJsonListRestaurant(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        pictureId: json["pictureId"],
        rating: json["rating"]?.toDouble(),
      );
}
