part of 'product_details_cubit.dart';

abstract class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object> get props => [];
}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsLoaded extends ProductDetailsState {
  final ProductEntity product;

  const ProductDetailsLoaded({
    required this.product,
  });

  @override
  List<Object> get props => [product];
}

class ProductDetailsError extends ProductDetailsState {
  final dynamic message;

  const ProductDetailsError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class ProductDetailsIncrementQuantityState extends ProductDetailsState {}

class ProductDetailsExpandDescriptionState extends ProductDetailsState {}
