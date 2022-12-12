import 'package:hive_flutter/hive_flutter.dart';

abstract class FavoriteLocalDataSource {
  Future<void> addFavorite(List<dynamic> favorite);
  Future<void> deleteFavorite(int id);
  Future<List<dynamic>> getFavorites();
}

class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  final favBox = Hive.box('userData');
  @override
  Future<void> addFavorite(List<dynamic> favorites) async {
    await favBox.put('favorite', favorites);
  }

  @override
  Future<void> deleteFavorite(int id) async {
    favBox.delete(id);
  }

  @override
  Future<List<dynamic>> getFavorites() async {
    return favBox.get('favorite') ?? [];
  }
}
