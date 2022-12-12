import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:store_task/features/home/domain/entities/category_entity.dart';

part 'product_entity.g.dart';

@HiveType(typeId: 0)
// ignore: must_be_immutable
class ProductEntity extends Equatable {
  @HiveField(0)
  int productId;
  @HiveField(1)
  String name;
  @HiveField(2)
  String image;
  @HiveField(3)
  String price;
  @HiveField(4)
  String description;
  @HiveField(5)
  String rate;
  @HiveField(6)
  CategoryEntity? category;

  @HiveField(7)
  int quantity;
  ProductEntity({
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.rate,
    this.category,
    this.quantity = 1,
  });

  // fromJson
  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      productId: json['id'],
      name: json['name'],
      image: json['image_link'],
      price: json['price'],
      description: json['description'],
      rate: json['rate'],
      category: CategoryEntity.fromJson(json['category']),
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'image_link': image,
      'price': price,
      'description': description,
      'rate': rate,
      'category': category!.toJson(),
    };
  }

  @override
  List<Object?> get props => [
        productId,
        name,
        image,
        price,
        description,
        rate,
        category,
        quantity,
      ];
}
