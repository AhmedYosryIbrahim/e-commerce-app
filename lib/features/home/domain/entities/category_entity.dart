// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'category_entity.g.dart';

@HiveType(typeId: 2)
class CategoryEntity extends Equatable {
  @HiveField(0)
  int cateId;
  @HiveField(1)
  String name;
  @HiveField(2)
  String image;

  CategoryEntity({
    required this.cateId,
    required this.name,
    required this.image,
  });

  factory CategoryEntity.fromJson(Map<String, dynamic> json) {
    return CategoryEntity(
      cateId: json['id'],
      name: json['name'],
      image: json['image_link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': cateId,
      'name': name,
      'image_link': image,
    };
  }

  @override
  List<Object?> get props => [cateId, name, image];
}
