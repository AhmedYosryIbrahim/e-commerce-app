import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_task/features/home/presentation/cubit/home_cubit.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';

class BottomNavBarButton extends StatelessWidget {
  final int index;
  final String title;
  final IconData icon;
  const BottomNavBarButton({
    required this.index,
    required this.title,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    void popAllRoutes(int index) {
      if (cubit.screenIndex != index) {
        cubit.changeScreenIndex(index);
      } else {
        //pop to first screen
        Navigator.of(context).canPop()
            ? Navigator.of(context).popUntil((route) => route.isFirst)
            : Navigator.of(context)
                .pushNamedAndRemoveUntil(Routes.initialRoute, (route) => false);
      }
    }

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return MaterialButton(
          onPressed: () {
            popAllRoutes(index);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: cubit.screenIndex == index
                    ? AppColors.primaryColor
                    : AppColors.iconColor,
              ),
              SizedBox(height: 8.h),
              Text(title,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: cubit.screenIndex == index
                            ? AppColors.primaryColor
                            : AppColors.iconColor,
                      )),
            ],
          ),
        );
      },
    );
  }
}
