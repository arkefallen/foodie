import 'package:foodie/data/model/restaurant_model.dart';

sealed class SearchRestaurantState {}

class SearchRestaurantInitial extends SearchRestaurantState {}

class SearchRestaurantLoading extends SearchRestaurantState {}

class SearchRestaurantSuccess extends SearchRestaurantState {
  final List<Restaurant> restaurant;

  SearchRestaurantSuccess({required this.restaurant});
}

class SearchRestaurantError extends SearchRestaurantState {
  final String error;

  SearchRestaurantError({required this.error});
}
