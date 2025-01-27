import 'package:flutter/material.dart';
import 'package:foodie/data/datasource/restaurant_service.dart';
import 'package:foodie/screens/state/list_restaurant_state.dart';

class ListRestaurantProvider with ChangeNotifier {
  ListRestaurantState _state = ListRestaurantInitial();
  final RestaurantService _restaurantService;

  ListRestaurantState get state => _state;

  ListRestaurantProvider({required RestaurantService restaurantService})
      : _restaurantService = restaurantService;

  Future<void> fetchListRestaurants() async {
    _state = ListRestaurantLoading();
    notifyListeners();

    final response = await _restaurantService.getListRestaurants();
    if (response.error != null && response.error as bool) {
      _state = ListRestaurantError(error: response.message.toString());
    } else {
      _state = ListRestaurantSuccess(restaurants: response.restaurants!.toList());
    }
    notifyListeners();
  }
}
