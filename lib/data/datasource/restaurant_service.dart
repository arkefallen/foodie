import 'package:foodie/data/model/add_review_model.dart';
import 'package:foodie/data/model/detail_restaurant_model.dart';
import 'package:foodie/data/model/list_restaurants_model.dart';
import 'package:foodie/data/model/search_restaurant_model.dart';
import 'package:http/http.dart' as http;

class RestaurantService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String getMethod = 'GET';
  static const String postMethod = 'POST';

  Future<ListRestaurants> getListRestaurants() async {
    try {
      var response = await http.get(Uri.parse('$_baseUrl/list'));
      if (response.statusCode == 200) {
        return ListRestaurants.fromRawJson(response.body);
      } else {
        throw Exception('Failed to load list restaurants');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<DetailRestaurant> getDetailRestaurant(String id) async {
    try {
      var request = http.Request(getMethod, Uri.parse('$_baseUrl/detail/$id'));

      http.StreamedResponse response = await request.send();

      var data = await response.stream.bytesToString();
      return DetailRestaurant.fromRawJson(data);
    } catch (e) {
      throw Exception('Failed to load detail restaurant');
    }
  }

  Future<SearchRestaurant> searchRestaurant(String query) async {
    try {
      var request =
          http.Request(getMethod, Uri.parse('$_baseUrl/search?q=$query'));

      http.StreamedResponse response = await request.send();

      var data = await response.stream.bytesToString();
      return SearchRestaurant.fromRawJson(data);
    } catch (e) {
      throw Exception('Failed to search restaurant');
    }
  }

  Future<AddReview> addReview(String id, String name, String review) async {
    try {
      var request = http.Request(postMethod, Uri.parse('$_baseUrl/review'));

      request.body = '''{
        "id": "$id",
        "name": "$name",
        "review": "$review"
      }''';

      request.headers.addAll({
        'Content-Type': 'application/json',
      });

      http.StreamedResponse response = await request.send();

      var data = await response.stream.bytesToString();
      return AddReview.fromRawJson(data);
    } catch (e) {
      throw Exception('Failed to add review');
    }
  }
}
