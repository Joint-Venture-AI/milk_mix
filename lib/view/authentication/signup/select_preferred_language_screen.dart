// lib/view/authentication/signup/select_preferred_language_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/constants/data/languages/language_selection_data.dart'
    as Language;
import 'package:milk_mix/constants/data/languages/language_storage.dart';
import 'package:milk_mix/routes.dart';
import 'package:milk_mix/view/widget/language_tile.dart';
import 'package:milk_mix/view/widget/text_button_widget.dart';

class SelectPreferredLanguageScreen extends StatefulWidget {
  const SelectPreferredLanguageScreen({super.key});

  @override
  State<SelectPreferredLanguageScreen> createState() =>
      _SelectPreferredLanguageScreenState();
}

class _SelectPreferredLanguageScreenState
    extends State<SelectPreferredLanguageScreen> {
  String selectedLanguage = 'en';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable content
            Expanded(
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
                      'selectLanguage'.tr,
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
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.w),
              child: TextWidgetButton(
                text: 'confirm'.tr,
                onPressed: () async {
                  try {
                    // Get the locale for the selected language
                    final locale = Language.getLocaleFromLanguageCode(
                      selectedLanguage,
                    );
                    final languageAndCountry =
                        Language.getLanguageAndCountryFromLocale(locale);

                    // Save to shared preferences
                    await LanguageStorage.init();
                    final success = await LanguageStorage.saveLanguage(
                      languageAndCountry['language']!,
                      languageAndCountry['country']!,
                    );

                    if (success) {
                      // Update the app locale
                      Get.updateLocale(
                        Locale(
                          languageAndCountry['language']!,
                          languageAndCountry['country'],
                        ),
                      );

                      // Navigate to next screen
                      Get.toNamed(AppRoutes.selectMeasurement);
                    } else {
                      // Still navigate but show error
                      Get.snackbar(
                        'Warning',
                        'Language preference could not be saved',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.orange,
                        colorText: Colors.white,
                      );
                      Get.toNamed(AppRoutes.selectMeasurement);
                    }
                  } catch (e) {
                    // Navigate even if there's an error
                    Get.toNamed(AppRoutes.selectMeasurement);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
