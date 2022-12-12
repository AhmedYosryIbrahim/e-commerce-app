import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/cart_repository.dart';

class DeleteItemFromCart extends UseCase<void, DeleteItemFromCartParams> {
  final CartRepository repository;

  DeleteItemFromCart(this.repository);

  @override
  Future<Either<Failures, void>> call(DeleteItemFromCartParams params) async {
    return await repository.deleteProductFromCart(params.id);
  }
}

class DeleteItemFromCartParams extends Equatable {
  final int id;

  const DeleteItemFromCartParams({required this.id});

  @override
  List<Object?> get props => [id];
}
