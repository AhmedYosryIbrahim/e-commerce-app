import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_task/core/utils/app_strings.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../home/presentation/cubit/home_cubit.dart';

class CartSummaryWidget extends StatelessWidget {
  const CartSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 12.h),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  '(${context.watch<HomeCubit>().calculateCartQuantity()})',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: AppColors.primaryColor),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(AppStrings.item,
                    style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
            Row(
              children: [
                Text(
                  AppStrings.total,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: AppColors.primaryColor),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                    '${context.watch<HomeCubit>().calculateCartTotal()} ${AppStrings.currncy}',
                    style: Theme.of(context).textTheme.bodyText1),
              ],
            )
          ],
        ),
      ),
    );
  }
}
