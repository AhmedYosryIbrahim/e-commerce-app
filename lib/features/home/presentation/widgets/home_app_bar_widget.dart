import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_task/core/utils/app_strings.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../authantication/presentation/widgets/custom_form_field.dart';
import 'package:store_task/injector.dart' as di;

import '../home_app_bar_cubit/cubit/app_bar_cubit.dart';

class HomeAppBartWidget extends StatelessWidget {
  const HomeAppBartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'assets/images/ADD.png',
      'assets/images/cmen.png',
    ];

    return BlocProvider(
      create: (context) => di.sl<AppBarCubit>(),
      child: BlocBuilder<AppBarCubit, AppBarState>(
        builder: (context, state) {
          return SliverAppBar(
            title: const Text(AppStrings.home),
            backgroundColor: AppColors.scaffoldBackground,
            floating: true,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              background: SizedBox(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        images[context.watch<AppBarCubit>().carosulIndex],
                        height: 200.h,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    ClipRRect(
                      // Clip it cleanly.
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          color: Colors.white.withOpacity(0.3),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              SizedBox(height: 70.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: CustomFormField(
                                  isReadOnly: true,
                                  hint: AppStrings.searchHint,
                                  fillColor: AppColors.white.withOpacity(0.6),
                                  prefix: const Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: 27.r,
                                  borderColor: Colors.transparent,
                                ),
                              ),

                              /// ad carousel
                              SizedBox(
                                height: 150.h,
                                width: 1.sw,
                                child: CarouselSlider(
                                  options: CarouselOptions(
                                    onPageChanged: (index, r) {
                                      context
                                          .read<AppBarCubit>()
                                          .changeCarosulIndex(index);
                                    },
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    viewportFraction: 0.8,
                                    aspectRatio: 2.0,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                  ),
                                  items: images.map((path) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5.0.w),
                                          child: Image.asset(
                                            path,
                                            fit: BoxFit.fill,
                                          ),
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                              // carosule indecators
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: images.map((path) {
                                  int index = images.indexOf(path);
                                  return Container(
                                    width: 13.0.w,
                                    height: 3.0.h,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10.0.h, horizontal: 4.0.w),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: context
                                                  .read<AppBarCubit>()
                                                  .carosulIndex ==
                                              index
                                          ? AppColors.primaryColor
                                          : Colors.grey,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            expandedHeight: 320.h,
          );
        },
      ),
    );
  }
}
