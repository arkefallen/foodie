sealed class RemoveFavoriteRestaurantState {}

class RemoveFavoriteRestaurantInitial extends RemoveFavoriteRestaurantState {}

class RemoveFavoriteRestaurantLoading extends RemoveFavoriteRestaurantState {}

class RemoveFavoriteRestaurantError extends RemoveFavoriteRestaurantState {
  final String error;

  RemoveFavoriteRestaurantError(this.error);
}

class RemoveFavoriteRestaurantSuccess extends RemoveFavoriteRestaurantState {
  final bool isSuccess;

  RemoveFavoriteRestaurantSuccess(this.isSuccess);
}
