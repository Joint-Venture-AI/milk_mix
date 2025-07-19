import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/routes.dart';
import 'package:milk_mix/view/widget/%20text_field_widget.dart';
import 'package:milk_mix/view/widget/text_button_widget.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  String selectedType = 'individual';

  final _individualEmailController = TextEditingController();
  final _individualPasswordController = TextEditingController();

  final _farmUsernameController = TextEditingController();
  final _farmEmailController = TextEditingController();
  final _farmPasswordController = TextEditingController();

  @override
  void dispose() {
    _individualEmailController.dispose();
    _individualPasswordController.dispose();
    _farmUsernameController.dispose();
    _farmEmailController.dispose();
    _farmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 54.h),
              Text(
                'loginType'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'loginTypeSubTitle'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textGrey,
                ),
              ),
              SizedBox(height: 24.h),

              // Toggle buttons
              Container(
                height: 45.h,
                decoration: BoxDecoration(
                  color: AppColors.shade,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    children: [
                      ToggleButton(
                        'individual',
                        'assets/logos/user-line.svg',
                        'individualUser'.tr,
                      ),
                      ToggleButton(
                        'farm',
                        'assets/logos/multi-user.svg',
                        'farmUser'.tr,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 42.h),
              selectedType == 'individual'
                  ? _buildIndividualForm()
                  : _buildFarmForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIndividualForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'email'.tr,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6.h),
        TextFieldWidget(
          hintText: 'enterYourEmail'.tr,
          keyboardType: TextInputType.emailAddress,
          assetIconPath: 'assets/logos/mail.svg',
          controller: _individualEmailController,
        ),
        SizedBox(height: 24.h),
        Text(
          'password'.tr,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6.h),
        TextFieldWidget(
          hintText: 'enterPassword'.tr,
          keyboardType: TextInputType.visiblePassword,
          assetIconPath: 'assets/logos/lock.svg',
          controller: _individualPasswordController,
          obscureText: true,
        ),
        SizedBox(height: 6.h),
        Align(
          alignment: Alignment.bottomRight,
          child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {},
            child: Text(
              'forgotPassword'.tr,
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 44.h),
        TextWidgetButton(
          text: 'loginIndividual'.tr,
          onPressed: () => Get.toNamed(AppRoutes.home),
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'dontHaveAnAccount'.tr,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(width: 8.w),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () => Get.toNamed(AppRoutes.createAccount),
              child: Text(
                'signUp'.tr,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFarmForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'farmUsername'.tr,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6.h),
        TextFieldWidget(
          hintText: 'farmUsername'.tr,
          keyboardType: TextInputType.text,
          assetIconPath: 'assets/logos/at.svg',
          controller: _farmUsernameController,
        ),
        SizedBox(height: 24.h),
        Text(
          'email'.tr,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6.h),
        TextFieldWidget(
          hintText: 'enterYourEmail'.tr,
          keyboardType: TextInputType.emailAddress,
          assetIconPath: 'assets/logos/mail.svg',
          controller: _farmEmailController,
        ),
        SizedBox(height: 24.h),
        Text(
          'password'.tr,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6.h),
        TextFieldWidget(
          hintText: 'enterPassword'.tr,
          keyboardType: TextInputType.visiblePassword,
          assetIconPath: 'assets/logos/lock.svg',
          controller: _farmPasswordController,
          obscureText: true,
        ),
        SizedBox(height: 44.h),
        TextWidgetButton(
          text: 'loginFarmMember'.tr,
          onPressed: () => Get.toNamed(AppRoutes.homeFarm),
        ),
      ],
    );
  }

  Widget ToggleButton(String value, String imagePath, String label) {
    final isSelected = selectedType == value;

    return Expanded(
      child: SizedBox(
        height: 33.h,
        child: GestureDetector(
          onTap: () => setState(() => selectedType = value),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(5.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  imagePath,
                  height: 16.h,
                  color: isSelected ? Colors.white : AppColors.textGrey,
                ),
                SizedBox(width: 6.w),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textGrey,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
