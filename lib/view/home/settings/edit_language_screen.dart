import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/constants/data/language_data.dart' as Language;
import 'package:milk_mix/view/authentication/signup/select_preferred_language_screen.dart';
import 'package:milk_mix/view/widget/appbar_widget.dart';
import 'package:milk_mix/view/widget/text_button_widget.dart';
import 'package:milk_mix/view/widget/text_button_widget_light.dart';

class EditLanguageScreen extends StatefulWidget {
  const EditLanguageScreen({super.key});

  @override
  State<EditLanguageScreen> createState() => _EditLanguageScreenState();
}

class _EditLanguageScreenState extends State<EditLanguageScreen> {
  String selectedLanguage = 'en';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppBarWidget(),
              SizedBox(height: 16.h),
              Text(
                'Change Language',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.h),
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
              SizedBox(height: 300.h),
              Row(
                children: [
                  Expanded(
                    child: TextButtonWidgetLight(
                      text: 'Cancel',
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: TextWidgetButton(text: 'Update', onPressed: () {}),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
