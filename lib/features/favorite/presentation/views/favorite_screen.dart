import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_task/core/utils/app_strings.dart';
import 'package:store_task/features/favorite/presentation/widgets/favorite_item_widget.dart';
import 'package:store_task/features/home/presentation/cubit/home_cubit.dart';
import 'package:store_task/features/home/presentation/widgets/custom_app_bar_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeCubit>().getFavoriteItems();
    return Scaffold(
      appBar: customAppBarWidget(
        title: AppStrings.favorite,
      ),
      drawer: const Drawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (context.read<HomeCubit>().favoriteItems.isEmpty) {
              return Center(
                  child: Text(
                AppStrings.noFav,
                style: Theme.of(context).textTheme.headline2,
              ));
            } else {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return FavoriteItemWidget(
                    product: context.read<HomeCubit>().favoriteItems[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10.h,
                  );
                },
                itemCount: context.read<HomeCubit>().favoriteItems.length,
              );
            }
          },
        ),
      ),
    );
  }
}
