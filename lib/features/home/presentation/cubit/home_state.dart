part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeChangeScreenIndexState extends HomeState {}

class HomeChangeCarosualIndexState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeGetCategoriesLoadedState extends HomeState {}

class HomeErrorState extends HomeState {
  final dynamic message;

  const HomeErrorState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class HomeGetMostRecenttProductsLoadedState extends HomeState {}

class HomeGetMostPopularLoadedState extends HomeState {}

class AddToFavoriteLoadingState extends HomeState {}

class AddToFavoriteSuccessState extends HomeState {
  final String message;

  const AddToFavoriteSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

class AddToFavoriteErrorState extends HomeState {
  final String message;

  const AddToFavoriteErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class DeleteFromFavoriteLoadingState extends HomeState {}

class DeleteFromFavoriteSuccessState extends HomeState {
  final String message;

  const DeleteFromFavoriteSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

class DeleteFromFavoriteErrorState extends HomeState {
  final String message;

  const DeleteFromFavoriteErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class AddToCartLoadingState extends HomeState {}

class AddToCartSuccessState extends HomeState {
  final String message;

  const AddToCartSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

class AddToCartErrorState extends HomeState {
  final String message;

  const AddToCartErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class DeleteFromCartLoadingState extends HomeState {}

class DeleteFromCartSuccessState extends HomeState {
  final String message;

  const DeleteFromCartSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

class DeleteFromCartErrorState extends HomeState {
  final String message;

  const DeleteFromCartErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class HomeGetCartItemsLoadedState extends HomeState {}

class HomeGetFavoriteLoadingState extends HomeState {}

class HomeGetFavoriteItemsLoadedState extends HomeState {}
