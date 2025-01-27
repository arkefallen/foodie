import 'dart:convert';

class Category {
  final String name;

  Category({
    required this.name,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class RestaurantCategory extends Category {
    RestaurantCategory({
    required super.name,
  });

  factory RestaurantCategory.fromRawJson(String str) => RestaurantCategory.fromJson(json.decode(str));

  factory RestaurantCategory.fromJson(Map<String, dynamic> json) => RestaurantCategory(
        name: json["name"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "name": name,
      };

  @override
  String toRawJson() => json.encode(toJson());
}

class Food extends Category {
  Food({
    required super.name,
  });

  factory Food.fromRawJson(String str) => Food.fromJson(json.decode(str));

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        name: json["name"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "name": name,
      };

  @override
  String toRawJson() => json.encode(toJson());
}

class Drink extends Category {
  Drink({
    required super.name,
  });

  factory Drink.fromRawJson(String str) => Drink.fromJson(json.decode(str));

  factory Drink.fromJson(Map<String, dynamic> json) => Drink(
        name: json["name"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "name": name,
      };

  @override
  String toRawJson() => json.encode(toJson());
}
