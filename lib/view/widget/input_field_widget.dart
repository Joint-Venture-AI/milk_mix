import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:milk_mix/constants/color.dart';

class InputFieldWidget extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final String iconPath;
  final bool obscureText;
  final TextInputType keyboardType;
  final Color? iconColor;

  const InputFieldWidget({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.iconPath,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6.h),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: AppColors.textLightGrey,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.all(12.w),
              child: SvgPicture.asset(
                iconPath,
                width: 20.w,
                height: 20.h,
                color: iconColor ?? AppColors.textPrimary,
              ),
            ),
            prefixIconConstraints: BoxConstraints(
              minWidth: 40.w,
              minHeight: 40.h,
            ),
          ),
          style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
        ),
      ],
    );
  }
}
