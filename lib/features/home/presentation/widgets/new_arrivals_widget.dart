import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_task/features/home/domain/entities/product_entity.dart';
import 'package:store_task/features/home/presentation/widgets/product_widget.dart';

import '../../../../core/utils/app_strings.dart';

class NewArrivalsWidget extends StatelessWidget {
  final List<ProductEntity> products;
  final String title;
  final Function() seeAllFunction;
  const NewArrivalsWidget({
    required this.products,
    required this.title,
    required this.seeAllFunction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: Theme.of(context).textTheme.headline6),
              TextButton(
                onPressed: seeAllFunction,
                child: Text(
                  AppStrings.seeAll,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 220.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ProductWidget(
                product: products[index],
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(width: 8.w);
            },
            itemCount: products.length,
          ),
        ),
      ],
    );
  }
}
