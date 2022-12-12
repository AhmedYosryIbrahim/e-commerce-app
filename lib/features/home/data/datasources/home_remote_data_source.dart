import 'package:store_task/core/api/api_consumer.dart';
import 'package:store_task/features/home/domain/entities/category_entity.dart';
import 'package:store_task/features/home/domain/entities/product_entity.dart';
import 'package:store_task/features/home/domain/usecases/get_latest_products.dart';

import '../../../../core/api/end_points.dart';

abstract class HomeRemoteDataSource {
  Future<List<CategoryEntity>> getCategories();

  Future<List<ProductEntity>> getProducts(GetProductsParams params);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiConsumer apiConsumer;

  HomeRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final response = await apiConsumer.get(Endpoints.getCategoriesUrl);
    return (response['results'] as List)
        .map((e) => CategoryEntity.fromJson(e))
        .toList();
  }

  @override
  Future<List<ProductEntity>> getProducts(GetProductsParams params) async {
    final response = await apiConsumer.get(
      params.categoryId == null
          ? Endpoints.getProductsUrl
          : '${Endpoints.getProductsUrl}category/${params.categoryId}',
    );
    return (response['results'] as List)
        .map((e) => ProductEntity.fromJson(e))
        .toList();
  }
}
