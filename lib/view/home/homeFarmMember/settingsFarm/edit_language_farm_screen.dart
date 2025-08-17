import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/constants/data/languages/language_selection_data.dart'
    as Language;
import 'package:milk_mix/constants/data/languages/language_storage.dart';
import 'package:milk_mix/view/widget/appbar_widget.dart';
import 'package:milk_mix/view/widget/language_tile.dart';
import 'package:milk_mix/view/widget/text_button_widget.dart';
import 'package:milk_mix/view/widget/text_button_widget_light.dart';

class EditLanguageFarmScreen extends StatefulWidget {
  const EditLanguageFarmScreen({super.key});

  @override
  State<EditLanguageFarmScreen> createState() => _EditLanguageFarmScreenState();
}

class _EditLanguageFarmScreenState extends State<EditLanguageFarmScreen> {
  String selectedLanguage = 'en';
  String selectedLocale = 'en_US';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCurrentLanguage();
  }

  Future<void> _loadCurrentLanguage() async {
    await LanguageStorage.init();
    final savedLocale = await LanguageStorage.getSavedLocale();

    if (savedLocale != null) {
      final languageAndCountry = Language.getLanguageAndCountryFromLocale(
        savedLocale,
      );
      setState(() {
        selectedLanguage = languageAndCountry['language'] ?? 'en';
        selectedLocale = savedLocale;
        isLoading = false;
      });
    } else {
      setState(() {
        selectedLanguage = 'en';
        selectedLocale = 'en_US';
        isLoading = false;
      });
    }
  }

  Future<void> _updateLanguage() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      // Get the locale for the selected language
      final locale = Language.getLocaleFromLanguageCode(selectedLanguage);
      final languageAndCountry = Language.getLanguageAndCountryFromLocale(
        locale,
      );

      // Save to shared preferences
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

        // Show success message
        Get.snackbar(
          'Success',
          'Language updated successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primary,
          colorText: Colors.white,
        );

        // Navigate back
        Get.back();
      } else {
        Get.snackbar(
          'Error',
          'Failed to update language',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while updating language',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

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
                'changeLanguage'.tr,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.h),
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else
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
                      text: 'cancel'.tr,
                      onPressed: isLoading ? () {} : () => Get.back(),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: TextWidgetButton(
                      text: 'update'.tr,
                      onPressed: isLoading ? null : _updateLanguage,
                    ),
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
