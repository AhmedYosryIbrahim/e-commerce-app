import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_task/core/utils/app_strings.dart';
import 'package:store_task/features/home/domain/entities/product_entity.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../home/presentation/cubit/home_cubit.dart';

class CartItemWidget extends StatelessWidget {
  final ProductEntity product;
  const CartItemWidget({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        Row(
          children: [
            CachedNetworkImage(
              imageUrl: product.image,
              width: 121.w,
              height: 111.h,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    '${product.price} ${AppStrings.currncy}',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    context.read<HomeCubit>().increaseQuantity(product);
                  },
                  child: Container(
                    width: 45.w,
                    height: 45.h,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text('${product.quantity}',
                    style: Theme.of(context).textTheme.bodyText1),
                SizedBox(
                  width: 10.w,
                ),
                InkWell(
                  onTap: () {
                    context.read<HomeCubit>().decreaseQuantity(product);
                  },
                  child: Container(
                    width: 45.w,
                    height: 45.h,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                    ),
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Text(
                ' ${double.parse(product.price) * product.quantity} ج.م',
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
            ),
            InkWell(
              onTap: () {
                context.read<HomeCubit>().deleteFromCart(product.productId);
              },
              child: Container(
                width: 45.w,
                height: 45.h,
                decoration: const BoxDecoration(
                  color: AppColors.secondaryColor,
                ),
                child: const Icon(
                  Icons.delete_forever_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
