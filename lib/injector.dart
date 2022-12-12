import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_task/features/authantication/domain/repositories/authantication_repository.dart';
import 'package:store_task/features/authantication/presentation/cubit/authantication_cubit.dart';
import 'package:store_task/features/cart/domain/usecases/add_to_cart.dart';
import 'package:store_task/features/favorite/data/datasources/favorite_local_data_source.dart';
import 'package:store_task/features/favorite/domain/usecases/delete_item_from_favorite.dart';
import 'package:store_task/features/home/presentation/cubit/home_cubit.dart';
import 'package:store_task/features/home/presentation/home_app_bar_cubit/cubit/app_bar_cubit.dart';
import 'package:store_task/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'core/api/api_consumer.dart';
import 'core/api/app_interceptors.dart';
import 'core/api/dio_consumer.dart';
import 'core/network_info/network_info.dart';
import 'features/authantication/data/datasources/authanticathion_local_data_source.dart';
import 'features/authantication/data/datasources/authantication_remote_data_source.dart';
import 'features/authantication/data/repositories/authantication_repository_impl.dart';
import 'features/authantication/domain/usecases/user_login.dart';
import 'features/authantication/domain/usecases/user_register.dart';
import 'features/cart/data/datasources/cart_local_data_source.dart';
import 'features/cart/data/repositories/cart_repository_impl.dart';
import 'features/cart/domain/repositories/cart_repository.dart';
import 'features/cart/domain/usecases/delete_item_from_cart.dart';
import 'features/cart/domain/usecases/get_cart.dart';
import 'features/favorite/data/repositories/favorite_repository_impl.dart';
import 'features/favorite/domain/repositories/favorite_repository.dart';
import 'features/favorite/domain/usecases/add_item_to_favorite.dart';
import 'features/favorite/domain/usecases/get_favorites.dart';
import 'features/home/data/datasources/home_remote_data_source.dart';
import 'features/home/data/repositories/home_repository_impl.dart';
import 'features/home/domain/entities/category_entity.dart';
import 'features/home/domain/entities/product_entity.dart';
import 'features/home/domain/repositories/home_repository.dart';
import 'features/home/domain/usecases/get_categories.dart';
import 'features/home/domain/usecases/get_latest_products.dart';
import 'features/product_details/data/datasources/product_details_remote_data_source.dart';
import 'features/product_details/data/repositories/product_details_repository_impl.dart';
import 'features/product_details/domain/repositories/product_details_repository.dart';
import 'features/product_details/domain/usecases/get_product_details.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc

  sl.registerFactory(() => HomeCubit(
        getCategories: sl(),
        getLatestProducts: sl(),
        getFavorites: sl(),
        addItemToFavorite: sl(),
        deleteItemFromFavorite: sl(),
        addToCart: sl(),
        deleteItemFromCart: sl(),
        getCartItems: sl(),
      ));
  sl.registerFactory(() => ProductDetailsCubit(
        getProductDetails: sl(),
      ));

  sl.registerFactory(() => AuthanticationCubit(
        userLogin: sl(),
        userRegister: sl(),
      ));

  sl.registerFactory(() => AppBarCubit());
  // Use cases
  //home use cases
  sl.registerLazySingleton(() => GetCategories(sl()));
  sl.registerLazySingleton(() => GetProducts(sl()));
  //product details use cases
  sl.registerLazySingleton(() => GetProductDetails(sl()));

  // favorite use cases
  sl.registerLazySingleton(() => GetFavorites(sl()));
  sl.registerLazySingleton(() => AddItemToFavorite(sl()));
  sl.registerLazySingleton(() => DeleteItemFromFavorite(sl()));

  // cart use cases
  sl.registerLazySingleton(() => GetCartItems(sl()));
  sl.registerLazySingleton(() => AddToCart(sl()));
  sl.registerLazySingleton(() => DeleteItemFromCart(sl()));
  //auth use cases
  sl.registerLazySingleton(() => UserLogin(sl()));
  sl.registerLazySingleton(() => UserRegister(sl()));

  // Repository
  // home repository
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));

  // product details repository
  sl.registerLazySingleton<ProductDetailsRepository>(
      () => ProductDetailsRepositoryImpl(
            remoteDataSource: sl(),
            networkInfo: sl(),
          ));

  // favorite repository
  sl.registerLazySingleton<FavoriteRepository>(() => FavoriteRepositoryImpl(
        localDataSource: sl(),
      ));

  // cart repository
  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(
        localDataSource: sl(),
      ));
  // auth repository
  sl.registerLazySingleton<AuthanticationRepository>(
      () => AuthanticationRepositoryImpl(
            remoteDataSource: sl(),
            localDataSource: sl(),
            networkInfo: sl(),
          ));
  // Data sources
  // home data sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(apiConsumer: sl()));
  // product details data sources
  sl.registerLazySingleton<ProductDetailsRemoteDataSource>(
      () => ProductDetailsRemoteDataSourceImpl(apiConsumer: sl()));

  // favorite data sources
  sl.registerLazySingleton<FavoriteLocalDataSource>(
      () => FavoriteLocalDataSourceImpl());

  // cart data sources
  sl.registerLazySingleton<CartLocalDataSource>(
      () => CartLocalDataSourceImpl());
  // auth data sources
  sl.registerLazySingleton<AuthanticationRemoteDataSource>(
      () => AuthanticationRemoteDataSourceImpl(apiConsumer: sl()));
  sl.registerLazySingleton<AuthanticationLocalDataSource>(
      () => AuthanticationLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  Hive.registerAdapter(ProductEntityAdapter());
  Hive.registerAdapter(CategoryEntityAdapter());
  sl.registerLazySingleton(() => AppInterceptors());
  sl.registerLazySingleton(() => LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        requestHeader: true,
        error: true,
      ));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio());
}
