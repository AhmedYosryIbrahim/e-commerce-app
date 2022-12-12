import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/favorite_repository.dart';

class AddItemToFavorite extends UseCase<String, List<dynamic>> {
  final FavoriteRepository favoriteRepository;

  AddItemToFavorite(this.favoriteRepository);

  @override
  Future<Either<Failures, String>> call(List<dynamic> params) async {
    return await favoriteRepository.addFavorite(params);
  }
}
