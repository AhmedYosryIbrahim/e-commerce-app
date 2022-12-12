import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_task/core/utils/app_strings.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../home/presentation/cubit/home_cubit.dart';

class CheckOutWidget extends StatelessWidget {
  const CheckOutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 15.h),
      child: Padding(
        padding: EdgeInsets.all(15.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.total,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: AppColors.primaryColor),
                ),
                Text(
                    '${context.watch<HomeCubit>().calculateCartTotal()} ${AppStrings.currncy}',
                    style: Theme.of(context).textTheme.headline6),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.tax,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: AppColors.primaryColor),
                ),
                Text('5 ${AppStrings.currncy}',
                    style: Theme.of(context).textTheme.headline6),
              ],
            ),
            const Divider(
              color: AppColors.iconColor,
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.finalTotal,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: AppColors.primaryColor),
                ),
                Text(
                    '${context.watch<HomeCubit>().calculateCartTotal() + 5} ${AppStrings.currncy}',
                    style: Theme.of(context).textTheme.headline6),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
