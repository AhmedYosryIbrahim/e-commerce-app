import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_task/core/errors/exceptions.dart';
import 'package:store_task/features/authantication/domain/entities/token_entity.dart';

abstract class AuthanticationLocalDataSource {
  Future<void> cacheToken(TokenEntity tokenModel);
  Future<String> getToken();
  Future<void> deleteToken();
}

class AuthanticationLocalDataSourceImpl
    implements AuthanticationLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthanticationLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheToken(TokenEntity tokenModel) {
    return sharedPreferences.setString('token', tokenModel.token);
  }

  @override
  Future<void> deleteToken() {
    return sharedPreferences.remove('token');
  }

  @override
  Future<String> getToken() async {
    final token = sharedPreferences.getString('token');
    if (token != null) {
      return token;
    } else {
      throw CachedException();
    }
  }
}
