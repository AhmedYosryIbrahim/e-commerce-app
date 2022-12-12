import 'package:dartz/dartz.dart';
import 'package:store_task/core/errors/failures.dart';

import '../../../../core/usecases/usecases.dart';
import '../repositories/cart_repository.dart';

class GetCartItems extends UseCase<List<dynamic>, NoParams> {
  final CartRepository repository;

  GetCartItems(this.repository);

  @override
  Future<Either<Failures, List<dynamic>>> call(NoParams params) async {
    return await repository.getCartProducts();
  }
}
