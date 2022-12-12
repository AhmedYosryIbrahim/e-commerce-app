import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_task/core/errors/failures.dart';

import '../../../home/domain/entities/product_entity.dart';
import '../../domain/usecases/get_product_details.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductDetails getProductDetails;
  ProductDetailsCubit({
    required this.getProductDetails,
  }) : super(ProductDetailsInitial());

  late ProductEntity product;
  Future<void> getProductDetailsById(int id) async {
    emit(ProductDetailsLoading());
    final result = await getProductDetails(ProductDetailsParams(id: id));
    result.fold(
      (failure) => emit(ProductDetailsError(message: failureToString(failure))),
      (product) {
        this.product = product;
        emit(ProductDetailsLoaded(product: product));
      },
    );
  }

  // incress quantity
  void incressQuantity() {
    emit(ProductDetailsInitial());
    product.quantity++;
    emit(ProductDetailsIncrementQuantityState());
  }

  // decress quantity
  void decressQuantity() {
    emit(ProductDetailsInitial());
    if (product.quantity > 1) {
      product.quantity--;
      emit(ProductDetailsIncrementQuantityState());
    }
  }

  //expand description
  bool isExpanded = false;
  void expandDescription() {
    emit(ProductDetailsInitial());
    isExpanded = !isExpanded;
    emit(ProductDetailsExpandDescriptionState());
  }
}
