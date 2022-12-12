import 'package:store_task/core/errors/exceptions.dart';
import 'package:store_task/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:store_task/core/network_info/network_info.dart';
import 'package:store_task/core/utils/app_strings.dart';
import 'package:store_task/features/home/domain/entities/category_entity.dart';
import 'package:store_task/features/home/domain/entities/product_entity.dart';
import 'package:store_task/features/home/domain/usecases/get_latest_products.dart';

import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failures, List<CategoryEntity>>> getCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCategories = await remoteDataSource.getCategories();
        return Right(remoteCategories);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message!));
      }
    } else {
      return const Left(
          NetworkFailure(message: AppStrings.noInternetConnection));
    }
  }

  @override
  Future<Either<Failures, List<ProductEntity>>> getLatestProducts(GetProductsParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getProducts(params);
        return Right(remoteProducts);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message!));
      }
    } else {
      return const Left(
          NetworkFailure(message: AppStrings.noInternetConnection));
    }
  }
}
