import 'package:store_task/core/api/api_consumer.dart';
import 'package:store_task/core/api/end_points.dart';
import 'package:store_task/features/authantication/domain/entities/token_entity.dart';
import 'package:store_task/features/authantication/domain/entities/user_entity.dart';

import '../../domain/usecases/user_login.dart';
import '../../domain/usecases/user_register.dart';

abstract class AuthanticationRemoteDataSource {
  Future<TokenEntity> userLogin(UserLoginParams params);

  Future<UserEntity> userRegister(UserRegisterParams params);
}

class AuthanticationRemoteDataSourceImpl
    implements AuthanticationRemoteDataSource {
  final ApiConsumer apiConsumer;

  AuthanticationRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<TokenEntity> userLogin(UserLoginParams params) async {
    final response = await apiConsumer.post(
      Endpoints.loginUrl,
      body: {
        'username': params.userName,
        'password': params.password,
      },
    );
    return TokenEntity.fromJson(response);
  }

  @override
  Future<UserEntity> userRegister(UserRegisterParams params) async {
    final response = await apiConsumer.post(
      Endpoints.registerUrl,
      body: {
        'email': params.email,
        'password': params.password,
        'first_name': params.firstName,
        'last_name': params.lastName,
        'username': params.username,
      },
    );
    return UserEntity.fromJson(response['user']);
  }
}
