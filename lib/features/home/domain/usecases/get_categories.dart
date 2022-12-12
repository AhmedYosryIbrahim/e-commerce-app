import 'package:dartz/dartz.dart';
import 'package:store_task/core/errors/failures.dart';
import 'package:store_task/features/home/domain/entities/category_entity.dart';
import 'package:store_task/features/home/domain/repositories/home_repository.dart';

import '../../../../core/usecases/usecases.dart';

class GetCategories extends UseCase<List<CategoryEntity>, NoParams> {
  final HomeRepository repository;

  GetCategories(this.repository);

  @override
  Future<Either<Failures, List<CategoryEntity>>> call(NoParams params) async {
    return await repository.getCategories();
  }
}
