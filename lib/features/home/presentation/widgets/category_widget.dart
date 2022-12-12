import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_task/features/home/domain/entities/category_entity.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryEntity category;
  const CategoryWidget({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 36.r,
          // ignore: use_full_hex_values_for_flutter_colors
          backgroundColor: const Color(0xff00000029),
          child: CircleAvatar(
              radius: 35.r,
              backgroundImage: CachedNetworkImageProvider(
                category.image,
              )),
        ),
        SizedBox(height: 7.h),
        Text(
          category.name,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
