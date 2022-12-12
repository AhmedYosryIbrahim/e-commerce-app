import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

class DefaultButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isDisabled;
  final Color color;
  final Color textColor;
  final double width;
  final double height;
  final double fontSize;
  final double borderRadius;
  final Color borderColor;
  final double elevation;
  final FontWeight fontWeight;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final Alignment alignment;

  const DefaultButton(
      {this.text,
      this.child,
      required this.onPressed,
      this.isLoading = false,
      this.isDisabled = false,
      this.color = AppColors.primaryColor,
      this.borderColor = AppColors.primaryColor,
      this.textColor = Colors.white,
      this.width = double.infinity,
      this.height = 40,
      this.fontSize = 16,
      this.borderRadius = 4,
      this.elevation = 0,
      this.fontWeight = FontWeight.bold,
      this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      this.margin,
      this.alignment = Alignment.center,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
            side: BorderSide(color: borderColor),
          ),
          padding: padding,
          elevation: elevation,
          alignment: alignment,
        ),
        child: child ??
            Center(
              child: Text(text ?? '',
                  style: TextStyle(
                      color: textColor,
                      fontSize: fontSize.sp,
                      fontWeight: fontWeight)),
            ),
      ),
    );
  }
}
