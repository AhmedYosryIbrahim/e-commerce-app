import 'package:store_task/core/errors/exceptions.dart';
import 'package:store_task/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:store_task/core/network_info/network_info.dart';
import 'package:store_task/core/utils/app_strings.dart';
import 'package:store_task/features/authantication/domain/entities/user_entity.dart';
import 'package:store_task/features/authantication/domain/usecases/user_login.dart';
import 'package:store_task/features/authantication/domain/entities/token_entity.dart';
import 'package:store_task/features/authantication/domain/usecases/user_register.dart';

import '../../domain/repositories/authantication_repository.dart';
import '../datasources/authanticathion_local_data_source.dart';
import '../datasources/authantication_remote_data_source.dart';

class AuthanticationRepositoryImpl implements AuthanticationRepository {
  final AuthanticationRemoteDataSource remoteDataSource;
  final AuthanticationLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthanticationRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failures, TokenEntity>> userLogin(
      UserLoginParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteToken = await remoteDataSource.userLogin(params);
        localDataSource.cacheToken(remoteToken);
        return Right(remoteToken);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message!));
      }
    } else {
      return const Left(
          NetworkFailure(message: AppStrings.noInternetConnection));
    }
  }

  @override
  Future<Either<Failures, UserEntity>> userRegister(
      UserRegisterParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser = await remoteDataSource.userRegister(params);
        return Right(remoteUser);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message!));
      }
    } else {
      return const Left(
          NetworkFailure(message: AppStrings.noInternetConnection));
    }
  }
}
