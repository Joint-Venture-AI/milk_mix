import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:milk_mix/constants/color.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final String? assetIconPath;
  final bool obscureText;
  final TextEditingController? controller;

  const TextFieldWidget({
    super.key,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.assetIconPath,
    this.obscureText = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.textLightGrey,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon:
            assetIconPath != null
                ? Padding(
                  padding: EdgeInsets.all(12.w),
                  child: SvgPicture.asset(
                    assetIconPath!,
                    width: 20.w,
                    height: 20.h,
                  ),
                )
                : null,
        prefixIconConstraints: BoxConstraints(minWidth: 40.w, minHeight: 40.h),
      ),
      style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
    );
  }
}
