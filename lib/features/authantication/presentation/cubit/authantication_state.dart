part of 'authantication_cubit.dart';

abstract class AuthanticationState extends Equatable {
  const AuthanticationState();

  @override
  List<Object> get props => [];
}

class AuthanticationInitialState extends AuthanticationState {}

class AuthanticationVisibilityChangedState extends AuthanticationState {}

class AuthanticationLoadingState extends AuthanticationState {}

class LoginSuccessState extends AuthanticationState {
  final TokenEntity tokenEntity;

  const LoginSuccessState({required this.tokenEntity});

  @override
  List<Object> get props => [tokenEntity];
}

class AuthanticationErrorState extends AuthanticationState {
  final dynamic message;

  const AuthanticationErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class RegisterSuccessState extends AuthanticationState {
  final UserEntity userEntity;

  const RegisterSuccessState({required this.userEntity});

  @override
  List<Object> get props => [userEntity];
}
