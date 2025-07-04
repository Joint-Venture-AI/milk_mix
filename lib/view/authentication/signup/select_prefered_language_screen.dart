import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/constants/language_data.dart' as Language;
import 'package:milk_mix/view/widget/text_button_widget.dart';

class SelectPreferedLanguageScreen extends StatefulWidget {
  const SelectPreferedLanguageScreen({super.key});

  @override
  State<SelectPreferedLanguageScreen> createState() =>
      _SelectPreferedLanguageScreenState();
}

class _SelectPreferedLanguageScreenState
    extends State<SelectPreferedLanguageScreen> {
  String selectedLanguage = 'en';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 12.h),
              SvgPicture.asset('assets/logos/language.svg', width: 150.w),
              SizedBox(height: 12.h),
              Text(
                textAlign: TextAlign.center,
                'Select your preferred language',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 25.h),
              for (var lang in Language.languages)
                LanguageTile(
                  flagPath: lang.flag,
                  language: lang.name,
                  isSelected: selectedLanguage == lang.code,
                  onTap: () {
                    setState(() {
                      selectedLanguage = lang.code;
                    });
                  },
                ),
              SizedBox(height: 30.h),
              TextWidgetButton(text: 'Confirm', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

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
              child:
                  isSelected
                      ? Icon(Icons.check, color: Colors.white, size: 14.sp)
                      : null,
            ),
          ],
        ),
      ),
    );
  }
}
