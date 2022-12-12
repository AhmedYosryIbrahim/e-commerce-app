import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:store_task/core/usecases/usecases.dart';
import 'package:store_task/features/authantication/domain/entities/user_entity.dart';
import 'package:store_task/features/authantication/domain/repositories/authantication_repository.dart';

import '../../../../core/errors/failures.dart';

class UserRegister extends UseCase<UserEntity, UserRegisterParams> {
  final AuthanticationRepository repository;

  UserRegister(this.repository);

  @override
  Future<Either<Failures, UserEntity>> call(UserRegisterParams params) async {
    return await repository.userRegister(params);
  }
}

class UserRegisterParams extends Equatable {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String username;

  const UserRegisterParams({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.username,
  });

  @override
  List<Object> get props => [
        email,
        password,
        firstName,
        lastName,
        username,
      ];
}
