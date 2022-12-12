import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/token_entity.dart';
import '../repositories/authantication_repository.dart';

class UserLogin extends UseCase<TokenEntity, UserLoginParams> {
  final AuthanticationRepository repository;

  UserLogin(this.repository);

  @override
  Future<Either<Failures, TokenEntity>> call(UserLoginParams params) async {
    return await repository.userLogin(params);
  }
}

class UserLoginParams extends Equatable {
  final String userName;
  final String password;

  const UserLoginParams({
    required this.userName,
    required this.password,
  });

  @override
  List<Object?> get props => [userName, password];
}
