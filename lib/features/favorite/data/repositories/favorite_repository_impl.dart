import 'package:store_task/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:store_task/core/utils/app_strings.dart';
import 'package:store_task/features/favorite/domain/repositories/favorite_repository.dart';
import '../datasources/favorite_local_data_source.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteLocalDataSource localDataSource;

  FavoriteRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failures, String>> addFavorite(List<dynamic> favorite) async {
    try {
      await localDataSource.addFavorite(favorite);

      return Future.value(const Right(AppStrings.addToFavSuccess));
    } catch (e) {
      return Future.value(
          const Left(CachedFailure(message: AppStrings.removeFromFavSuccess)));
    }
  }

  @override
  Future<Either<Failures, List<dynamic>>> getFavorites() async {
    try {
      final favorites = await localDataSource.getFavorites();
      return Future.value(Right(favorites));
    } catch (e) {
      return Future.value(
          const Left(CachedFailure(message: AppStrings.getFavoriteError)));
    }
  }

  @override
  Future<Either<Failures, String>> deleteFavorite(int id) async {
    try {
      await localDataSource.deleteFavorite(id);
      return Future.value(const Right(AppStrings.removeFromFavSuccess));
    } catch (e) {
      return Future.value(
          const Left(CachedFailure(message: AppStrings.removeFromFavError)));
    }
  }
}
