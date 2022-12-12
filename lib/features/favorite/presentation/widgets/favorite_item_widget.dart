import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store_task/features/home/domain/entities/product_entity.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../../../authantication/presentation/widgets/default_button.dart';
import '../../../home/presentation/cubit/home_cubit.dart';

class FavoriteItemWidget extends StatelessWidget {
  final ProductEntity product;
  const FavoriteItemWidget({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CachedNetworkImage(
              imageUrl: product.image,
              height: 0.3.sh,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15.h, horizontal: 16.w),
              child: Text(
                product.name,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 15.h),
              child: Text('${product.price} ${AppStrings.currncy}',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: AppColors.primaryColor,
                      )),
            ),
            DefaultButton(
                text: AppStrings.favAddToCart,
                onPressed: () {
                  if (context.read<HomeCubit>().isInCart(product.productId)) {
                    Constants.showToast(
                      message: AppStrings.alreadyInCart,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 14.sp,
                    );
                  } else {
                    context.read<HomeCubit>().addToCartFun(product);
                  }
                }),
          ]),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            icon: const Icon(Icons.favorite, color: AppColors.secondaryColor),
            onPressed: () {
              context.read<HomeCubit>().deleteFavorite(product.productId);
            },
          ),
        )
      ],
    );
  }
}
