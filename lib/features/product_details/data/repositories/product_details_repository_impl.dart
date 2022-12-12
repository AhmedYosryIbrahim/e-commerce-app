import 'package:store_task/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:store_task/features/home/domain/entities/product_entity.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network_info/network_info.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/repositories/product_details_repository.dart';
import '../datasources/product_details_remote_data_source.dart';

class ProductDetailsRepositoryImpl implements ProductDetailsRepository {
  final ProductDetailsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductDetailsRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failures, ProductEntity>> getProductDetails(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await remoteDataSource.getProductDetails(id);
        return Right(remoteProduct);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message!));
      }
    } else {
      return const Left(
          NetworkFailure(message: AppStrings.noInternetConnection));
    }
  }
}
