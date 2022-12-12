import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_task/core/utils/app_strings.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';
import '../../domain/entities/product_entity.dart';
import '../cubit/home_cubit.dart';

class ProductWidget extends StatelessWidget {
  final ProductEntity product;
  const ProductWidget({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Constants.navigateNamedTo(
          context: context,
          route: Routes.productDetailsRoute,
          isRootNavigator: false,
          args: product.productId),
      child: Stack(
        children: [
          Card(
            child: SizedBox(
              width: 133.w,
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: product.image,
                    height: 121.h,
                    width: 115.w,
                    maxWidthDiskCache: 200,
                    maxHeightDiskCache: 200,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.w, right: 10.w, left: 10.w),
                    height: 30.h,
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      product.name,
                      style: Theme.of(context).textTheme.bodyText2,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${product.price} ${AppStrings.currncy}',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                        ),
                        IconButton(
                            onPressed: () {
                              if (context
                                  .read<HomeCubit>()
                                  .isInCart(product.productId)) {
                                context
                                    .read<HomeCubit>()
                                    .deleteFromCart(product.productId);
                              } else {
                                context.read<HomeCubit>().addToCartFun(product);
                              }
                            },
                            icon: Icon(
                              Icons.add_shopping_cart_rounded,
                              color: context
                                      .watch<HomeCubit>()
                                      .isInCart(product.productId)
                                  ? AppColors.primaryColor
                                  : Colors.black38,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                if (context.read<HomeCubit>().isInFavorite(product.productId)) {
                  context.read<HomeCubit>().deleteFavorite(product.productId);
                } else {
                  context.read<HomeCubit>().addFavorite(product);
                }
              },
              icon: context.watch<HomeCubit>().isInFavorite(product.productId)
                  ? const Icon(
                      Icons.favorite,
                      color: AppColors.secondaryColor,
                    )
                  : const Icon(Icons.favorite_border))
        ],
      ),
    );
  }
}
