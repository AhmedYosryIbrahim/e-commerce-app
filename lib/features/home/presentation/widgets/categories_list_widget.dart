import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_task/features/home/domain/entities/category_entity.dart';

import 'category_widget.dart';

class CategoriesListWidget extends StatelessWidget {
  final List<CategoryEntity> categories;
  const CategoriesListWidget({required this.categories, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 32.h),
      height: 0.15.sh,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CategoryWidget(category: categories[index]);
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: 8.w);
        },
        itemCount: categories.length,
      ),
    );
  }
}
