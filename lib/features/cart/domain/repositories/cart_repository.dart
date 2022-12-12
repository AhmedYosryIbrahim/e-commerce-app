import 'package:dartz/dartz.dart';
import 'package:store_task/core/errors/failures.dart';

abstract class CartRepository {
  Future<Either<Failures, void>> addProductToCart(List<dynamic> product);
  Future<Either<Failures, void>> deleteProductFromCart(int id);
  Future<Either<Failures, List<dynamic>>> getCartProducts();
}
