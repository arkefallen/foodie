import 'package:flutter/material.dart';
import 'package:foodie/data/datasource/restaurant_service.dart';
import 'package:foodie/screens/state/add_review_state.dart';

class AddReviewProvider with ChangeNotifier {
  AddReviewState _state = AddReviewInitial();
  final RestaurantService _restaurantService = RestaurantService();

  AddReviewState get state => _state;

  void resetState() {
    _state = AddReviewInitial();
    notifyListeners();
  }

  Future<void> addReview(
      String restaurantId, String name, String review) async {
    _state = AddReviewLoading();
    notifyListeners();

    try {
      final response =
          await _restaurantService.addReview(restaurantId, name, review);
      if (!response.error) {
        _state = AddReviewSuccess(response.customerReviews, response.message);
      } else {
        _state = AddReviewError(response.message);
      }
      notifyListeners();
    } catch (e) {
      _state = AddReviewError(e.toString());
      notifyListeners();
    }
  }
}
