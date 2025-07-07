import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:milk_mix/constants/color.dart';

class SettingTile extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback onTap;
  final Color? color;

  const SettingTile({
    super.key,
    required this.iconPath,
    required this.title,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final tileColor = color ?? AppColors.textPrimary;

    return Column(
      children: [
        Divider(color: AppColors.lightGrey, thickness: 1.h, height: 6.h),
        ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 8.h),
          leading: SvgPicture.asset(iconPath, height: 20.w, color: tileColor),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: tileColor,
            ),
          ),
          trailing: Icon(Icons.chevron_right, color: tileColor),
          onTap: onTap,
        ),
      ],
    );
  }
}
