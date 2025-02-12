import 'package:flutter_test/flutter_test.dart';
import 'package:foodie/data/model/customer_review_model.dart';
import 'package:foodie/data/model/list_restaurants_model.dart';
import 'package:foodie/data/model/menu_category.dart';
import 'package:foodie/data/model/menus_model.dart';
import 'package:foodie/data/model/restaurant_model.dart';
import 'package:foodie/provider/list_restaurant_provider.dart';
import 'package:foodie/screens/state/list_restaurant_state.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks.dart';

void main() {
  late MockRestaurantService mockRestaurantService;
  late ListRestaurantProvider listRestaurantProvider;

  setUp(() {
    mockRestaurantService = MockRestaurantService();
    listRestaurantProvider =
        ListRestaurantProvider(restaurantService: mockRestaurantService);
  });

  group("Fetch List Restaurant Unit Test", () {
    test('should return ListRestaurantInitial() when provider initialized', () {
      final initState = listRestaurantProvider.state;
      expect(initState, ListRestaurantInitial());
    });

    test(
        'should return ListRestaurantSuccess() when RestaurantService returns data',
        () async {
      final data = [
        Restaurant(
          id: "id",
          name: "name",
          address: "address",
          pictureId: "pictureId",
          categories: [
            RestaurantCategory(
              name: "name",
            )
          ],
          menus: Menus(
            foods: [
              Food(name: "food"),
            ],
            drinks: [Drink(name: "drink")],
          ),
          rating: 5.0,
          customerReviews: [
            CustomerReview(
              name: "name",
              review: "review",
              date: "date",
            ),
          ],
        )
      ];

      when(() => mockRestaurantService.getListRestaurants()).thenAnswer(
        (_) => Future.value(
          ListRestaurants(
            count: 1,
            error: false,
            message: "Success",
            restaurants: data,
          ),
        ),
      );

      await listRestaurantProvider.fetchListRestaurants();

      expect(
        listRestaurantProvider.state,
        equals(ListRestaurantSuccess(restaurants: data)),
      );
    });
  });

  test(
      'should return ListRestaurantError() when RestaurantService returns Exception',
      () async {
    const data = "Error from Exception";

    when(() => mockRestaurantService.getListRestaurants()).thenAnswer(
      (_) => Future.error(data),
    );

    await listRestaurantProvider.fetchListRestaurants();

    expect(
      listRestaurantProvider.state,
      equals(ListRestaurantError(error: data)),
    );
  });

  test(
      'should return ListRestaurantError() when RestaurantService payload "error" equals to true',
      () async {
    final data = [
      Restaurant(
        id: "id",
        name: "name",
        address: "address",
        pictureId: "pictureId",
        categories: [
          RestaurantCategory(
            name: "name",
          )
        ],
        menus: Menus(
          foods: [
            Food(name: "food"),
          ],
          drinks: [Drink(name: "drink")],
        ),
        rating: 5.0,
        customerReviews: [
          CustomerReview(
            name: "name",
            review: "review",
            date: "date",
          ),
        ],
      )
    ];

    const errorMessage = "Error when 'error' property equals to true";

    when(() => mockRestaurantService.getListRestaurants()).thenAnswer(
      (_) => Future.value(
        ListRestaurants(
          count: 1,
          error: true,
          message: errorMessage,
          restaurants: data,
        ),
      ),
    );

    await listRestaurantProvider.fetchListRestaurants();

    expect(
      listRestaurantProvider.state,
      equals(ListRestaurantError(error: errorMessage)),
    );
  });

  test(
      'should return ListRestaurantLoading() when RestaurantService returns error but not in async',
      () {
    const data = "Error from Exception";

    when(() => mockRestaurantService.getListRestaurants()).thenAnswer(
      (_) => Future.error(data),
    );

    listRestaurantProvider.fetchListRestaurants();

    expect(
      listRestaurantProvider.state,
      equals(ListRestaurantLoading()),
    );
  });
}
