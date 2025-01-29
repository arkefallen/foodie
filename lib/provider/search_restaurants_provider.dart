import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodie/data/datasource/restaurant_service.dart';
import 'package:foodie/screens/state/search_restaurant_state.dart';

class SearchRestaurantsProvider with ChangeNotifier {
  final RestaurantService _restaurantService = RestaurantService();
  SearchRestaurantState _state = SearchRestaurantInitial();

  SearchRestaurantState get state => _state;

  Future<void> searchRestaurants(String query) async {
    _state = SearchRestaurantLoading();
    notifyListeners();

    try {
      final response = await _restaurantService.searchRestaurant(query);
      if (response.error) {
        _state = SearchRestaurantError(error: "Error");
      } else {
        _state = SearchRestaurantSuccess(restaurant: response.restaurants);
      }
      notifyListeners();
    } on SocketException catch (e) {
      _state = SearchRestaurantError(error: e.message);
      notifyListeners();
    } on Exception catch (e) {
      _state = SearchRestaurantError(error: e.toString());
      notifyListeners();
    }
  }
}
