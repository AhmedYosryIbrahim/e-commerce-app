import 'package:dartz/dartz.dart';
import 'package:store_task/core/utils/app_strings.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_local_data_source.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failures, void>> addProductToCart(List<dynamic> product) async {
    try {
      await localDataSource.addProductToCart(product);
      return const Right(null);
    } catch (e) {
      return const Left(CachedFailure(message: AppStrings.addToCartError));
    }
  }

  @override
  Future<Either<Failures, List<dynamic>>> getCartProducts() async {
    try {
      final products = await localDataSource.getCartProducts();
      return Right(products);
    } catch (e) {
      return const Left(CachedFailure(message: AppStrings.getCartError));
    }
  }

  @override
  Future<Either<Failures, void>> deleteProductFromCart(int id) async {
    try {
      await localDataSource.deleteProductFromCart(id);
      return const Right(null);
    } catch (e) {
      return const Left(CachedFailure(message: AppStrings.removeFromCartError));
    }
  }
}
