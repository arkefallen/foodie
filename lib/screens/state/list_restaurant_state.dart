import 'package:equatable/equatable.dart';
import 'package:foodie/data/model/restaurant_model.dart';

sealed class ListRestaurantState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ListRestaurantInitial extends ListRestaurantState {}

class ListRestaurantLoading extends ListRestaurantState {}

class ListRestaurantSuccess extends ListRestaurantState {
  final List<Restaurant> restaurants;

  ListRestaurantSuccess({required this.restaurants});

  @override
  List<Object?> get props => [restaurants];
}

class ListRestaurantError extends ListRestaurantState {
  final String error;

  ListRestaurantError({required this.error});

  @override
  List<Object?> get props => [error];
}
