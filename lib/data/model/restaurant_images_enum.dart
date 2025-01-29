enum RestaurantImage {
  small,
  medium,
  large,
}

extension RestaurantImageSizeExtension on RestaurantImage {
  String get baseUrl {
    switch (this) {
      case RestaurantImage.small:
        return 'https://restaurant-api.dicoding.dev/images/small/';
      case RestaurantImage.medium:
        return 'https://restaurant-api.dicoding.dev/images/medium/';
      case RestaurantImage.large:
        return 'https://restaurant-api.dicoding.dev/images/large/';
      default:
        return '';
    }
  }

  String getImageUrl(String pictureId) {
    return '$baseUrl$pictureId';
  }
}
