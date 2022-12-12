import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store_task/core/utils/app_colors.dart';
import 'package:store_task/core/utils/app_strings.dart';
import 'package:store_task/core/utils/constants.dart';
import 'package:store_task/features/authantication/presentation/widgets/default_button.dart';
import 'package:store_task/features/home/presentation/cubit/home_cubit.dart';
import 'package:store_task/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:store_task/features/product_details/presentation/widgets/change_quantity_widget.dart';
import 'package:store_task/features/product_details/presentation/widgets/product_image_widget.dart';

import '../widgets/description_widget.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductDetailsCubit>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView(
              children: [
                Column(children: [
                  ProductImageWidget(product: cubit.product),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 15.h),
                          alignment: AlignmentDirectional.topStart,
                          child: Text(cubit.product.name,
                              style: Theme.of(context).textTheme.headline5),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${cubit.product.price} ${AppStrings.currncy}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                      color: AppColors.primaryColor,
                                    )),
                            Row(
                              children: [
                                Text(cubit.product.rate.toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                                SizedBox(
                                  width: 5.w,
                                ),
                                const Icon(Icons.star, color: Colors.yellow),
                              ],
                            ),
                          ],
                        ),
                        DescriptionExpandedWidget(
                          isExpanded: cubit.isExpanded,
                          onTap: () => context
                              .read<ProductDetailsCubit>()
                              .expandDescription(),
                          description: cubit.product.description,
                        ),
                        //row for item count and price
                        ChangeQuantityWidget(
                          addTap: () {
                            context
                                .read<ProductDetailsCubit>()
                                .incressQuantity();
                          },
                          removeTap: () {
                            context
                                .read<ProductDetailsCubit>()
                                .decressQuantity();
                          },
                          product: cubit.product,
                        ),

                        DefaultButton(
                          width: 0.5.sw,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.shopping_cart_checkout,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(AppStrings.addToCart,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.white,
                                        )),
                              ]),
                          onPressed: () {
                            if (context
                                .read<HomeCubit>()
                                .isInCart(cubit.product.productId)) {
                              Constants.showToast(
                                message: AppStrings.alreadyInCart,
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 14.sp,
                              );
                            } else {
                              context
                                  .read<HomeCubit>()
                                  .addToCartFun(cubit.product);
                            }
                          },
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                      ],
                    ),
                  ),
                ]),
              ],
            );
          }
        },
      ),
    );
  }
}
