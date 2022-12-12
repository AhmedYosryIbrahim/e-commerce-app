import 'package:dartz/dartz.dart';
import 'package:store_task/core/errors/failures.dart';
import 'package:store_task/features/authantication/domain/entities/user_entity.dart';

import '../entities/token_entity.dart';
import '../usecases/user_login.dart';
import '../usecases/user_register.dart';

abstract class AuthanticationRepository {
  Future<Either<Failures, TokenEntity>> userLogin(UserLoginParams params);

  Future<Either<Failures, UserEntity>> userRegister(UserRegisterParams params);
}
