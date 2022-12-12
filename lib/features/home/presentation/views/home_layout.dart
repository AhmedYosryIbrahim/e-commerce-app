import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store_task/core/errors/failures.dart';
import 'package:store_task/core/utils/app_strings.dart';
import 'package:store_task/core/utils/constants.dart';
import 'package:store_task/features/home/presentation/views/cateories_screen.dart';
import 'package:store_task/features/home/presentation/views/home_screen.dart';
import 'package:store_task/features/home/presentation/widgets/bottom_nav_bar_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../cart/presentation/views/cart_screen.dart';
import '../../../favorite/presentation/views/favorite_screen.dart';
import '../../../profile_view/profiel_screen.dart';
import '../cubit/home_cubit.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(),
      const CategoriesScreen(),
      const CartScreen(),
      const FavoriteScreen(),
      const ProfileScreen(),
    ];
    final cubit = context.read<HomeCubit>();

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeErrorState) {
          showError(context, state.message);
        }
        if (state is AddToCartErrorState) {
          Constants.showToast(
            message: state.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: AppColors.error,
            textColor: Colors.white,
            fontSize: 16.0.sp,
          );
        }
        if (state is AddToFavoriteErrorState) {
          Constants.showToast(
            message: state.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: AppColors.error,
            textColor: Colors.white,
            fontSize: 16.0.sp,
          );
        }
        if (state is DeleteFromCartErrorState) {
          Constants.showToast(
            message: state.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: AppColors.error,
            textColor: Colors.white,
            fontSize: 16.0.sp,
          );
        }
        if (state is DeleteFromFavoriteErrorState) {
          Constants.showToast(
            message: state.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: AppColors.error,
            textColor: Colors.white,
            fontSize: 16.0.sp,
          );
        }

        if (state is AddToCartSuccessState) {
          Constants.showToast(
            message: state.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0.sp,
          );
        }
        if (state is AddToFavoriteSuccessState) {
          Constants.showToast(
            message: state.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0.sp,
          );
        }
        if (state is DeleteFromCartSuccessState) {
          Constants.showToast(
            message: state.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0.sp,
          );
        }
        if (state is DeleteFromFavoriteSuccessState) {
          Constants.showToast(
            message: state.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0.sp,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: screens[cubit.screenIndex],
          floatingActionButton: cubit.cartItems.isEmpty
              ? null
              : Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: cubit.screenIndex == 2
                              ? const Color(0xffFF87B3)
                              : AppColors.secondaryColor,
                          width: 2,
                          style: BorderStyle.solid)),
                  width: 60.w,
                  height: 60.h,
                  child: FloatingActionButton(
                    onPressed: () {
                      cubit.changeScreenIndex(2);
                    },
                    backgroundColor: AppColors.secondaryColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${context.watch<HomeCubit>().calculateCartQuantity()}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.white, fontSize: 14.sp),
                        ),
                        Icon(
                          Icons.shopping_cart,
                          size: 20.sp,
                        ),
                      ],
                    ),
                  ),
                ),
          resizeToAvoidBottomInset: false,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 4.0,
            child: SizedBox(
              height: 60.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      BottomNavBarButton(
                          index: 0, title: AppStrings.home, icon: Icons.home),
                      BottomNavBarButton(
                          index: 1,
                          title: AppStrings.category,
                          icon: Icons.category)
                    ],
                  ),
                  // Right Tab bar icons
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      BottomNavBarButton(
                        index: 3,
                        title: AppStrings.favorite,
                        icon: Icons.favorite,
                      ),
                      BottomNavBarButton(
                          index: 4,
                          title: AppStrings.profile,
                          icon: Icons.person)
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
