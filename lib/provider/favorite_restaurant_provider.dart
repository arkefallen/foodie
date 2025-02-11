import 'package:flutter/material.dart';
import 'package:foodie/data/datasource/local_database_service.dart';
import 'package:foodie/data/model/restaurant_model.dart';
import 'package:foodie/screens/state/add_favorite_restaurant_state.dart';
import 'package:foodie/screens/state/list_favorite_restaurants_state.dart';
import 'package:foodie/screens/state/remove_favorite_restaurant_state.dart';

class FavoriteRestaurantProvider with ChangeNotifier {
  final LocalDatabaseService _localDatabaseService;

  FavoriteRestaurantProvider(this._localDatabaseService);

  ListFavoriteRestaurantState _restaurantState =
      ListFavoriteRestaurantInitial();

  AddFavoriteRestaurantState _addFavoriteRestaurantState =
      AddFavoriteRestaurantInitial();

  RemoveFavoriteRestaurantState _removeFavoriteRestaurantState =
      RemoveFavoriteRestaurantInitial();

  List<Restaurant> _favoriteRestaurants = [];
  bool _isFavorite = false;

  List<Restaurant> get favoriteRestaurants => _favoriteRestaurants;
  bool get isFavorite => _isFavorite;

  ListFavoriteRestaurantState get restaurantState => _restaurantState;
  AddFavoriteRestaurantState get addFavoriteState =>
      _addFavoriteRestaurantState;
  RemoveFavoriteRestaurantState get removeFavoriteState =>
      _removeFavoriteRestaurantState;

  Future<void> loadFavoriteRestaurant() async {
    try {
      final result = await _localDatabaseService.getFavoriteRestaurants();
      if (result.isNotEmpty) {
        _restaurantState = ListFavoriteRestaurantSuccess(result, false);
        _favoriteRestaurants = result;
      } else {
        _restaurantState = ListFavoriteRestaurantSuccess(result, true);
      }
      notifyListeners();
    } catch (e) {
      _restaurantState = ListFavoriteRestaurantError("Error: ${e.toString()}");
      notifyListeners();
    }
  }

  void addRestaurant(Restaurant restaurant) async {
    try {
      final result = await _localDatabaseService.insertData(restaurant);
      if (result > 0) {
        _addFavoriteRestaurantState = AddFavoriteRestaurantSuccess(true);
        _favoriteRestaurants.add(restaurant);
        _isFavorite = true;
        notifyListeners();
      } else {
        throw Exception("Ada kesalahan");
      }
    } catch (e) {
      _addFavoriteRestaurantState =
          AddFavoriteRestaurantError("Error: ${e.toString()}");
      notifyListeners();
    }
  }

  void removeRestaurant(Restaurant restaurant) async {
    try {
      final result = await _localDatabaseService
          .deleteFavoriteRestaurant(restaurant.id.toString());
      if (result > 0) {
        _removeFavoriteRestaurantState = RemoveFavoriteRestaurantSuccess(true);
        _favoriteRestaurants.remove(restaurant);
        _isFavorite = false;
        notifyListeners();
      } else {
        _removeFavoriteRestaurantState = RemoveFavoriteRestaurantSuccess(false);
        notifyListeners();
      }
    } catch (e) {
      _removeFavoriteRestaurantState =
          RemoveFavoriteRestaurantError("Error: ${e.toString()}");
      notifyListeners();
    }
  }

  void checkIsFavorite(String restaurantId) async {
    try {
      final result =
          await _localDatabaseService.getFavoriteRestaurantById(restaurantId);
      if (result.id != null) {
        _isFavorite = true;
        notifyListeners();
      } else {
        _isFavorite = false;
        notifyListeners();
      }
    } catch (e) {
      if (e.toString().contains("No element")) {
        _isFavorite = false;
        notifyListeners();
      }
    }
  }

  bool isThisItemFavorite(String restaurantId) {
    return _favoriteRestaurants
        .any((restaurant) => restaurant.id.toString() == restaurantId);
  }
}
