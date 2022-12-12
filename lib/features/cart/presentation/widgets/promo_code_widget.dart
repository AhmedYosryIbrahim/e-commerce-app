import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store_task/core/utils/app_strings.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../authantication/presentation/widgets/custom_form_field.dart';
import '../../../authantication/presentation/widgets/default_button.dart';

class PromoCodeWidget extends StatelessWidget {
  const PromoCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 15.h,
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          SvgPicture.asset(
            'assets/images/promo_code_image.svg',
            width: 1.sw,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.h,
            ),
            width: 0.8.sw,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppStrings.doYouHavePromoCode,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: AppColors.white,
                      ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomFormField(
                      height: 40.h,
                      hint: AppStrings.enterCode,
                      width: 0.35.sw,
                      fillColor: AppColors.white.withOpacity(0.5),
                      borderRadius: 5.r,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    DefaultButton(
                      onPressed: () {},
                      color: AppColors.white,
                      text: AppStrings.applyCode,
                      textColor: AppColors.black,
                      width: 0.23.sw,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
