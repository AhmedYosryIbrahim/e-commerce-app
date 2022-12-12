import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_task/core/utils/app_strings.dart';
import 'package:store_task/features/home/presentation/cubit/home_cubit.dart';

import '../widgets/custom_app_bar_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBarWidget(
          title: AppStrings.categories,
        ),
        drawer: const Drawer(),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          CachedNetworkImage(
                            imageUrl: context
                                .read<HomeCubit>()
                                .categories[index]
                                .image,
                            height: 122.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            context.read<HomeCubit>().categories[index].name,
                            style: Theme.of(context).textTheme.headline1,
                          )
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 16.h,
                      );
                    },
                    itemCount: context.read<HomeCubit>().categories.length,
                  ));
            }
          },
        ));
  }
}
