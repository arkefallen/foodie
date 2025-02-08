import 'package:foodie/data/model/restaurant_model.dart';

sealed class ListFavoriteRestaurantState {}

class ListFavoriteRestaurantInitial extends ListFavoriteRestaurantState {}

class ListFavoriteRestaurantLoading extends ListFavoriteRestaurantState {}

class ListFavoriteRestaurantError extends ListFavoriteRestaurantState {
  final String error;

  ListFavoriteRestaurantError(this.error);
}

class ListFavoriteRestaurantSuccess extends ListFavoriteRestaurantState {
  final List<Restaurant> restaurants;
  final bool isEmpty;

  ListFavoriteRestaurantSuccess(this.restaurants, this.isEmpty);
}
