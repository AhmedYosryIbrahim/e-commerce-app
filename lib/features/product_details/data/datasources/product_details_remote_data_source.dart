import 'package:store_task/features/home/domain/entities/product_entity.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';

abstract class ProductDetailsRemoteDataSource {
  Future<ProductEntity> getProductDetails(int id);
}

class ProductDetailsRemoteDataSourceImpl
    implements ProductDetailsRemoteDataSource {
  final ApiConsumer apiConsumer;

  ProductDetailsRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<ProductEntity> getProductDetails(int id) async {
    final response = await apiConsumer.get('${Endpoints.getProductsUrl}$id');
    return ProductEntity.fromJson(response[0]);
  }
}
