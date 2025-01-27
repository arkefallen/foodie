import 'package:foodie/data/model/restaurant_model.dart';

sealed class ListRestaurantState {}

class ListRestaurantInitial extends ListRestaurantState {}

class ListRestaurantLoading extends ListRestaurantState {}

class ListRestaurantSuccess extends ListRestaurantState {
  final List<Restaurant> restaurants;

  ListRestaurantSuccess({required this.restaurants});
}

class ListRestaurantError extends ListRestaurantState {
  final String error;

  ListRestaurantError({required this.error});
}
