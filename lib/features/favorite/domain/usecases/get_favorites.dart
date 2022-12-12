import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/favorite_repository.dart';

class GetFavorites extends UseCase<List<dynamic>, NoParams> {
  final FavoriteRepository repository;

  GetFavorites(this.repository);

  @override
  Future<Either<Failures, List<dynamic>>> call(NoParams params) async {
    return await repository.getFavorites();
  }
}
