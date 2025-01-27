import 'package:foodie/data/model/restaurant_model.dart';

sealed class DetailRestaurantState {}

class DetailRestaurantInitial extends DetailRestaurantState {}

class DetailRestaurantLoading extends DetailRestaurantState {}

class DetailRestaurantSuccess extends DetailRestaurantState {
  final Restaurant restaurant;

  DetailRestaurantSuccess({required this.restaurant});
}

class DetailRestaurantError extends DetailRestaurantState {
  final String error;

  DetailRestaurantError({required this.error});
}
