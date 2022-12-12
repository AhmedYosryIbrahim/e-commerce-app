import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:store_task/core/errors/failures.dart';
import 'package:store_task/features/product_details/domain/repositories/product_details_repository.dart';

import '../../../../core/usecases/usecases.dart';
import '../../../home/domain/entities/product_entity.dart';

class GetProductDetails extends UseCase<ProductEntity, ProductDetailsParams> {
  final ProductDetailsRepository repository;

  GetProductDetails(this.repository);

  @override
  Future<Either<Failures, ProductEntity>> call(
      ProductDetailsParams params) async {
    return await repository.getProductDetails(params.id);
  }
}

class ProductDetailsParams extends Equatable {
  final int id;

  const ProductDetailsParams({required this.id});

  @override
  List<Object?> get props => [id];
}
