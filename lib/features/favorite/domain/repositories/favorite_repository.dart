import 'package:dartz/dartz.dart';
import 'package:store_task/core/errors/failures.dart';

abstract class FavoriteRepository {
  Future<Either<Failures, List<dynamic>>> getFavorites();
  Future<Either<Failures, String>> addFavorite(List<dynamic> favorite);
  Future<Either<Failures, String>> deleteFavorite(int id);
}
