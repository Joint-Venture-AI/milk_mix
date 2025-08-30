import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/data_source/api/provider/api_config.dart';

class ProfileImageCircle extends StatelessWidget {
  final String image;
  final double size;
  const ProfileImageCircle({
    super.key,
    required this.image,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular((size / 2).r),
      child: Image.network(
        ApiConfig.baseUrl + image,
        fit: BoxFit.cover,
        width: size.w,
        height: size.w,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: size.w,
            height: size.w,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular((size / 2).r),
            ),
            child: Icon(Icons.person, size: (size * .7).w, color: Colors.white),
          );
        },
      ),
    );
  }
}
