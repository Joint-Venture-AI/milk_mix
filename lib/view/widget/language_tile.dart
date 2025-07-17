import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:milk_mix/constants/color.dart';

class LanguageTile extends StatelessWidget {
  final String flagPath;
  final String language;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageTile({
    super.key,
    required this.flagPath,
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.textLightGrey,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(radius: 16.r, backgroundImage: AssetImage(flagPath)),
            SizedBox(width: 12.w),
            Expanded(child: Text(language, style: TextStyle(fontSize: 16.sp))),
            Container(
              width: 20.sp,
              height: 20.sp,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.grey,
                  width: 1.w,
                ),
                color: isSelected ? AppColors.primary : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(Icons.check, color: Colors.white, size: 14.sp)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}