import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

class CustomFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final double? height;
  final double? width;
  final bool? isPassword;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final Function(String)? onChanged;
  final Function(String)? onSaved;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final Widget? prefix;
  final Widget? suffix;
  final bool? isClickable;
  final bool? isReadOnly;
  final int? maxLines;
  final int? maxLength;
  final Color? fillColor;
  final double borderRadius;
  final Color borderColor;
  final List<TextInputFormatter>? inputFormatters;

  const CustomFormField({
    Key? key,
    this.label,
    this.hint,
    this.height = 60,
    this.width = double.infinity,
    this.isPassword = false,
    this.controller,
    this.textInputType,
    this.onTap,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.prefix,
    this.suffix,
    this.isClickable = true,
    this.isReadOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.fillColor,
    this.borderRadius = 4,
    this.borderColor = AppColors.primaryColor,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h, top: 12.h),
      height: height != null ? height!.h : null,
      width: width,
      child: TextFormField(
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 12.sp,
            color: AppColors.textGray,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius.r)),
            borderSide: BorderSide(color: borderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius.r)),
            borderSide: BorderSide(color: borderColor),
          ),
          fillColor: fillColor ?? AppColors.white,
          filled: true,
          labelText: label,
          labelStyle: TextStyle(color: AppColors.primaryColor, fontSize: 12.sp),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius.r)),
            borderSide: BorderSide(color: borderColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius.r)),
            borderSide: const BorderSide(color: AppColors.error),
          ),
          contentPadding: const EdgeInsets.all(15),
          prefixIcon: prefix,
          suffixIcon: suffix,
        ),
        controller: controller,
        obscureText: isPassword!,
        maxLines: maxLines,
        onFieldSubmitted: onSaved,
        onChanged: onChanged,
        readOnly: isReadOnly!,
        onTap: onTap,
        cursorColor: AppColors.secondaryColor,
        keyboardType: textInputType,
        validator: validator,
      ),
    );
  }
}
