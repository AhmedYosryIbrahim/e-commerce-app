import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../home/domain/entities/product_entity.dart';

abstract class ProductDetailsRepository {
  Future<Either<Failures, ProductEntity>> getProductDetails(int id);
}
