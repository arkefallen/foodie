import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodie/data/datasource/restaurant_service.dart';
import 'package:foodie/screens/state/detail_restaurant_state.dart';

class DetailRestaurantProvider with ChangeNotifier {
  final RestaurantService _restaurantService = RestaurantService();

  DetailRestaurantState _state = DetailRestaurantInitial();
  DetailRestaurantState get state => _state;

  Future<void> fetchDetailRestaurant(String id) async {
    _state = DetailRestaurantLoading();
    notifyListeners();

    try {
      final response = await _restaurantService.getDetailRestaurant(id);
      if (response.error) {
        _state = DetailRestaurantError(error: response.message);
      } else {
        _state = DetailRestaurantSuccess(restaurant: response.restaurant);
      }
      notifyListeners();
    } on SocketException catch (e) {
      _state = DetailRestaurantError(error: e.message);
      notifyListeners();
    } on Exception catch (e) {
      _state = DetailRestaurantError(error: e.toString());
      notifyListeners();
    }
  }
}
