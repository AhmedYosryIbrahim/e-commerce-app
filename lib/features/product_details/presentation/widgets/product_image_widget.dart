import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_task/features/home/domain/entities/product_entity.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../home/presentation/cubit/home_cubit.dart';

class ProductImageWidget extends StatelessWidget {
  final ProductEntity product;
  const ProductImageWidget({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: product.image,
          height: 0.4.sh,
          maxHeightDiskCache: 500,
          maxWidthDiskCache: 500,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.white,
          margin: EdgeInsets.only(bottom: 20.h),
          child: Row(
            children: [
              Expanded(
                child: MaterialButton(
                    onPressed: () {
                      if (context
                          .read<HomeCubit>()
                          .isInFavorite(product.productId)) {
                        context
                            .read<HomeCubit>()
                            .deleteFavorite(product.productId);
                      } else {
                        context.read<HomeCubit>().addFavorite(product);
                      }
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.favorite,
                            color: context
                                    .watch<HomeCubit>()
                                    .isInFavorite(product.productId)
                                ? AppColors.secondaryColor
                                : AppColors.iconColor),
                        context
                                .watch<HomeCubit>()
                                .isInFavorite(product.productId)
                            ? Text(AppStrings.inFavorite,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(color: AppColors.secondaryColor))
                            : Text(AppStrings.addToFavorite,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(color: AppColors.iconColor)),
                      ],
                    )),
              ),
              Container(
                width: 1.w,
                height: 50.h,
                color: Colors.grey,
              ),
              Expanded(
                child: MaterialButton(
                    onPressed: () {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(Icons.share, color: AppColors.iconColor),
                        Text(AppStrings.shareProduct,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: AppColors.iconColor)),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
