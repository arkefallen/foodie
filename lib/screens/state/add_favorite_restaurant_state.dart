sealed class AddFavoriteRestaurantState {}

class AddFavoriteRestaurantInitial extends AddFavoriteRestaurantState {}

class AddFavoriteRestaurantLoading extends AddFavoriteRestaurantState {}

class AddFavoriteRestaurantError extends AddFavoriteRestaurantState {
  final String error;

  AddFavoriteRestaurantError(this.error);
}

class AddFavoriteRestaurantSuccess extends AddFavoriteRestaurantState {
  final bool isSuccess;

  AddFavoriteRestaurantSuccess(this.isSuccess);
}
