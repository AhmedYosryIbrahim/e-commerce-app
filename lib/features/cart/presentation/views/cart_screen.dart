import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_task/config/routes/app_routes.dart';
import 'package:store_task/core/utils/app_colors.dart';
import 'package:store_task/core/utils/app_strings.dart';
import 'package:store_task/core/utils/constants.dart';
import 'package:store_task/features/authantication/presentation/widgets/default_button.dart';
import 'package:store_task/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:store_task/features/cart/presentation/widgets/cart_summary_widget.dart';
import 'package:store_task/features/cart/presentation/widgets/check_out_widget.dart';
import 'package:store_task/features/cart/presentation/widgets/promo_code_widget.dart';
import 'package:store_task/features/home/presentation/widgets/custom_app_bar_widget.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import 'package:store_task/injector.dart' as di;

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    cubit.getCartItemsFun();
    return Scaffold(
        appBar: customAppBarWidget(title: AppStrings.cartTitle),
        drawer: const Drawer(),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                children: [
                  const CartSummaryWidget(),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => CartItemWidget(
                      product: cubit.cartItems[index],
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10.h,
                    ),
                    itemCount: cubit.cartItems.length,
                  ),
                  const PromoCodeWidget(),
                  const CheckOutWidget(),
                  DefaultButton(
                    onPressed: () {
                      if (di
                              .sl<SharedPreferences>()
                              .getString(AppStrings.token) ==
                          null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppStrings.loginFirst,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                              ],
                            ),
                            backgroundColor: AppColors.error,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.r),
                            ),
                          ),
                        );
                        Constants.navigateNamedTo(
                            context: context, route: Routes.loginRoute);
                      } else if (cubit.cartItems.isEmpty) {
                        Constants.showToast(
                          message: AppStrings.addSomeProduct,
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.sp,
                        );
                      } else {
                        Constants.showToast(
                          message: AppStrings.compeleteOrderSuccess,
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.sp,
                        );
                      }
                      // add to cart
                    },
                    text: AppStrings.compeleteOrder,
                    textColor: AppColors.white,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                ],
              ),
            );
          },
        ));
  }
}
