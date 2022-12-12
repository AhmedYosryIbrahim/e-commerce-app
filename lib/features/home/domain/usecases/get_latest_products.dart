import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:store_task/core/errors/failures.dart';
import 'package:store_task/features/home/domain/repositories/home_repository.dart';

import '../../../../core/usecases/usecases.dart';
import '../entities/product_entity.dart';

class GetProducts extends UseCase<List<ProductEntity>, GetProductsParams> {
  final HomeRepository repository;

  GetProducts(this.repository);

  @override
  Future<Either<Failures, List<ProductEntity>>> call(
      GetProductsParams params) async {
    return await repository.getLatestProducts(params);
  }
}

class GetProductsParams extends Equatable {
  final int? categoryId;

  const GetProductsParams({this.categoryId});

  @override
  List<Object?> get props => [categoryId];
}
