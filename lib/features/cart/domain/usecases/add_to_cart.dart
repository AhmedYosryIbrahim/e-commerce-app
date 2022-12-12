import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/cart_repository.dart';

class AddToCart extends UseCase<void, AddToCartParams> {
  final CartRepository repository;

  AddToCart(this.repository);

  @override
  Future<Either<Failures, void>> call(AddToCartParams params) async {
    return await repository.addProductToCart(params.products);
  }
}

class AddToCartParams extends Equatable {
  final List<dynamic> products;

  const AddToCartParams({required this.products});

  @override
  List<Object?> get props => [products];
}
