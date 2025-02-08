import 'package:foodie/data/model/restaurant_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseService {
  static const String _databaseName = 'favorite_restaurants.db';
  static const String _tableName = 'favorite_restaurants';

  Future<Database> _initDatabase() async {
    final database = await openDatabase(
      _databaseName,
      version: 1,
      onCreate: _onCreate,
    );
    return database;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id TEXT PRIMARY KEY,
        name TEXT,
        city TEXT,
        rating TEXT,
        picture_id TEXT
      )
    ''');
  }

  Future<int> insertData(Restaurant restaurant) async {
    final db = await _initDatabase();
    final succeedInsertedId = await db.insert(
      _tableName,
      restaurant.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return succeedInsertedId;
  }

  Future<List<Restaurant>> getFavoriteRestaurants() async {
    final db = await _initDatabase();
    return await db.query(_tableName).then((queries) {
      return queries
          .map((restaurantJson) => Restaurant.fromLocalDbJson(restaurantJson))
          .toList();
    });
  }

  Future<int> deleteFavoriteRestaurant(String id) async {
    final db = await _initDatabase();
    final numberOfRowsAffected = await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return numberOfRowsAffected;
  }

  Future<Restaurant> getFavoriteRestaurantById(String id) async {
    final db = await _initDatabase();
    return await db
        .query(_tableName, where: 'id = ?', whereArgs: [id], limit: 1)
        .then((query) => query
            .map((restaurantJson) => Restaurant.fromLocalDbJson(restaurantJson))
            .first);
  }
}
