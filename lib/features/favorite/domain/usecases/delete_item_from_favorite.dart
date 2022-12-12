import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/favorite_repository.dart';

class DeleteItemFromFavorite
    extends UseCase<String, DeleteItemFromFavoriteParams> {
  final FavoriteRepository repository;

  DeleteItemFromFavorite(this.repository);

  @override
  Future<Either<Failures, String>> call(
      DeleteItemFromFavoriteParams params) async {
    return await repository.deleteFavorite(params.id);
  }
}

class DeleteItemFromFavoriteParams extends Equatable {
  final int id;

  const DeleteItemFromFavoriteParams({required this.id});

  @override
  List<Object?> get props => [id];
}
