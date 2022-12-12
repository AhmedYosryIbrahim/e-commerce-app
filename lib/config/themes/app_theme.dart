import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/app_colors.dart';

ThemeData appTheme() {
  return ThemeData(
      primaryColor: AppColors.primaryColor,
      hintColor: Colors.grey,
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        elevation: 5,
        color: Colors.white,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors.textGray,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'Tajawal',
        ),
        iconTheme: const IconThemeData(
          color: AppColors.iconColor,
        ),
      ),
      fontFamily: 'Tajawal',
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStateColor.resolveWith(
                  (states) => AppColors.primaryColor),
              textStyle: MaterialStateTextStyle.resolveWith((states) =>
                  const TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 14,
                      fontWeight: FontWeight.w400)))),
      textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
          headline2: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textGray,
          ),
          headline3: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.secondaryColor,
          ),
          headline5: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textGray,
          ),
          headline6: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textGray,
          ),
          bodyText1: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textGray,
          ),
          bodyText2: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textGray,
          ),
          caption: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          )));
}
