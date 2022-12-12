import 'package:dartz/dartz.dart';
import 'package:store_task/core/errors/failures.dart';
import 'package:store_task/features/home/domain/entities/category_entity.dart';
import 'package:store_task/features/home/domain/entities/product_entity.dart';

import '../usecases/get_latest_products.dart';

abstract class HomeRepository {
  Future<Either<Failures, List<CategoryEntity>>> getCategories();

  Future<Either<Failures, List<ProductEntity>>> getLatestProducts(
      GetProductsParams params);
}
