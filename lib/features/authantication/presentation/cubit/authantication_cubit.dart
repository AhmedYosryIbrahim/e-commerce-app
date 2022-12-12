import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_task/core/errors/failures.dart';
import 'package:store_task/features/authantication/domain/usecases/user_login.dart';
import 'package:store_task/features/authantication/domain/usecases/user_register.dart';

import '../../domain/entities/token_entity.dart';
import '../../domain/entities/user_entity.dart';

part 'authantication_state.dart';

class AuthanticationCubit extends Cubit<AuthanticationState> {
  final UserLogin userLogin;
  final UserRegister userRegister;
  AuthanticationCubit({
    required this.userLogin,
    required this.userRegister,
  }) : super(AuthanticationInitialState());

  bool visibility = false;
  void changePasswordVisibility() {
    emit(AuthanticationInitialState());
    visibility = !visibility;
    emit(AuthanticationVisibilityChangedState());
  }

  Future<void> login({
    required String userName,
    required String password,
  }) async {
    emit(AuthanticationLoadingState());
    final result = await userLogin(UserLoginParams(
      userName: userName,
      password: password,
    ));
    result.fold(
      (failure) =>
          emit(AuthanticationErrorState(message: failureToString(failure))),
      (token) => emit(LoginSuccessState(tokenEntity: token)),
    );
  }

  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String username,
  }) async {
    emit(AuthanticationLoadingState());
    final result = await userRegister(UserRegisterParams(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      username: username,
    ));
    result.fold(
      (failure) =>
          emit(AuthanticationErrorState(message: failureToString(failure))),
      (user) => emit(RegisterSuccessState(userEntity: user)),
    );
  }
}
