import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:milk_mix/constants/color.dart';

class SettingTile extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback onTap;

  const SettingTile({
    super.key,
    required this.iconPath,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(color: AppColors.lightGrey, thickness: 1.h, height: 6.h),
        ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 8.h),
          leading: SvgPicture.asset(iconPath, height: 20.w),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          trailing: Icon(Icons.chevron_right, color: AppColors.textPrimary),
          onTap: onTap,
        ),
      ],
    );
  }
}
