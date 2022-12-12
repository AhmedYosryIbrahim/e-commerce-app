import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_task/core/errors/failures.dart';
import 'package:store_task/core/utils/app_strings.dart';
import 'package:store_task/features/cart/domain/usecases/add_to_cart.dart';
import 'package:store_task/features/cart/domain/usecases/delete_item_from_cart.dart';
import 'package:store_task/features/cart/domain/usecases/get_cart.dart';
import 'package:store_task/features/favorite/domain/usecases/add_item_to_favorite.dart';
import 'package:store_task/features/favorite/domain/usecases/get_favorites.dart';
import 'package:store_task/features/home/domain/usecases/get_categories.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../favorite/domain/usecases/delete_item_from_favorite.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/get_latest_products.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCategories getCategories;
  final GetFavorites getFavorites;
  final AddItemToFavorite addItemToFavorite;
  final DeleteItemFromFavorite deleteItemFromFavorite;
  final GetProducts getLatestProducts;
  final AddToCart addToCart;
  final DeleteItemFromCart deleteItemFromCart;
  final GetCartItems getCartItems;
  HomeCubit({
    required this.getCategories,
    required this.getLatestProducts,
    required this.getFavorites,
    required this.addItemToFavorite,
    required this.deleteItemFromFavorite,
    required this.addToCart,
    required this.deleteItemFromCart,
    required this.getCartItems,
  }) : super(HomeInitialState());

  int screenIndex = 0;

  void changeScreenIndex(int index) {
    emit(HomeInitialState());
    screenIndex = index;
    emit(HomeChangeScreenIndexState());
  }

  List<CategoryEntity> categories = [];
  Future<void> getCategoriesList() async {
    emit(HomeLoadingState());
    final result = await getCategories(NoParams());
    result.fold(
      (failure) => emit(HomeErrorState(message: failureToString(failure))),
      (categories) {
        this.categories = categories;
        emit(HomeGetCategoriesLoadedState());
      },
    );
  }

  List<ProductEntity> mostRecentList = [];
  List<ProductEntity> mostPopularProducts = [];

  Future<void> getMostRecentProductsList({int? categoryId}) async {
    emit(HomeLoadingState());
    final result = await getLatestProducts(GetProductsParams(
      categoryId: categoryId,
    ));

    result.fold(
        (failure) => emit(HomeErrorState(message: failureToString(failure))),
        (products) {
      mostRecentList = products;
      emit(HomeGetMostRecenttProductsLoadedState());
    });
  }

  Future<void> getMostPopularProducts({int? categoryId}) async {
    emit(HomeLoadingState());
    final result = await getLatestProducts(GetProductsParams(
      categoryId: categoryId,
    ));

    result.fold(
        (failure) => emit(HomeErrorState(message: failureToString(failure))),
        (products) {
      mostPopularProducts = products;
      emit(HomeGetMostPopularLoadedState());
    });
  }

  List<dynamic> favoriteItems = [];

  Future<void> getFavoriteItems() async {
    emit(HomeLoadingState());
    final result = await getFavorites(NoParams());
    result.fold(
      (failure) => emit(HomeErrorState(message: failureToString(failure))),
      (products) {
        favoriteItems = products;
        emit(HomeGetFavoriteItemsLoadedState());
      },
    );
  }

  bool isInFavorite(int id) {
    return favoriteItems.any((element) => element.productId == id);
  }

  bool isInCart(int id) {
    return cartItems.any((element) => element.productId == id);
  }

  Future<void> addFavorite(ProductEntity productModel) async {
    emit(AddToFavoriteLoadingState());
    favoriteItems.add(productModel);
    final result = await addItemToFavorite(favoriteItems);
    result.fold(
      (failure) {
        favoriteItems.remove(productModel);
        emit(AddToFavoriteErrorState(message: failure.message));
      },
      (message) {
        emit(AddToFavoriteSuccessState(message: message));
      },
    );
  }

  Future<void> deleteFavorite(int id) async {
    emit(DeleteFromFavoriteLoadingState());
    final result = await deleteItemFromFavorite(DeleteItemFromFavoriteParams(
      id: id,
    ));
    result.fold(
      (failure) => emit(DeleteFromFavoriteErrorState(message: failure.message)),
      (message) {
        favoriteItems.removeWhere((element) => element.productId == id);
        emit(const DeleteFromFavoriteSuccessState(
            message: AppStrings.removeFromFavSuccess));
      },
    );
  }

  Future<void> addToCartFun(ProductEntity productModel) async {
    emit(AddToCartLoadingState());
    cartItems.add(productModel);
    final result = await addToCart(AddToCartParams(
      products: cartItems,
    ));
    result.fold(
      (failure) {
        cartItems.remove(productModel);
        emit(AddToCartErrorState(message: failure.message));
      },
      (message) {
        emit(const AddToCartSuccessState(message: AppStrings.addToCartSuccess));
      },
    );
  }

  // increase quantity
  Future<void> increaseQuantity(ProductEntity productModel) async {
    emit(AddToCartLoadingState());
    productModel.quantity++;
    final result = await addToCart(AddToCartParams(
      products: cartItems,
    ));
    result.fold(
      (failure) => emit(AddToCartErrorState(message: failure.message)),
      (message) {
        emit(const AddToCartSuccessState(message: AppStrings.addToCartSuccess));
      },
    );
  }

  // decrease quantity
  Future<void> decreaseQuantity(ProductEntity productModel) async {
    emit(AddToCartLoadingState());
    final Either<Failures, void> result;

    if (productModel.quantity == 1) {
      deleteFromCart(productModel.productId);
    } else {
      productModel.quantity--;
      result = await addToCart(AddToCartParams(
        products: cartItems,
      ));
      result.fold(
        (failure) => emit(AddToCartErrorState(message: failure.message)),
        (message) {
          emit(const AddToCartSuccessState(
              message: AppStrings.addToCartSuccess));
        },
      );
    }
  }

  Future<void> deleteFromCart(int id) async {
    emit(DeleteFromCartLoadingState());
    final result = await deleteItemFromCart(DeleteItemFromCartParams(
      id: id,
    ));
    result.fold(
      (failure) => emit(DeleteFromCartErrorState(message: failure.message)),
      (message) {
        cartItems.removeWhere((element) => element.productId == id);

        emit(const DeleteFromCartSuccessState(
            message: AppStrings.removeFromCartSuccess));
      },
    );
  }

  List<dynamic> cartItems = [];
  Future<void> getCartItemsFun() async {
    emit(HomeLoadingState());
    final result = await getCartItems(NoParams());
    result.fold(
      (failure) => emit(HomeErrorState(message: failureToString(failure))),
      (cartItems) {
        this.cartItems = cartItems;
        emit(HomeGetCartItemsLoadedState());
      },
    );
  }

  // calculate cart quantity
  int calculateCartQuantity() {
    int quantity = 0;
    for (var element in cartItems) {
      quantity += element.quantity as int;
    }
    return quantity;
  }

  // calculate cart total
  double calculateCartTotal() {
    double total = 0;
    for (var element in cartItems) {
      total += double.parse(element.price) * element.quantity;
    }
    return total;
  }
}
