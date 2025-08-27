import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/model/get_milk_history_response.dart';

class RecipeSummaryDialog extends StatelessWidget {
  final GetMilkHistoryData historyData;

  const RecipeSummaryDialog({super.key, required this.historyData});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      backgroundColor: AppColors.surface,
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/logos/clip.svg',
                  height: 20.h,
                  width: 20.h,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Recipe Summary',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _buildRow(
              'assets/logos/bottle.svg',
              'Number of Bottles',
              ' = ${historyData.numberOfBottles ?? 'N/A'}',
            ),
            _buildRow(
              'assets/logos/drop.svg',
              'Hospital Milk ${historyData.unit == null ? '' : '(${historyData.unit!})'}',
              ' = ${historyData.hospitalMilkVolume?.toStringAsFixed(0) ?? 'N/A'}',
            ),
            _buildRow(
              'assets/logos/bottleGreen.svg',
              'Bottle Size',
              ' = ${historyData.bottleSize?.toStringAsFixed(0) ?? 'N/A'}',
            ),
            _buildRow(
              'assets/logos/bottleMed.svg',
              'Solids in Hospital Milk (%)',
              ' = ${historyData.hospitalSolids?.toStringAsFixed(2) ?? 'N/A'} %',
            ),
            _buildRow(
              'assets/logos/bottleMed.svg',
              'Desired Solids(11-16%)',
              ' = ${historyData.desiredSolidsContent?.toStringAsFixed(2) ?? 'N/A'} %',
            ),

            Divider(color: Colors.grey.shade300, thickness: 1, height: 15.h),
            _buildRow(
              'assets/logos/drop.svg',
              'Water',
              ' = ${historyData.poundsOfWater?.toStringAsFixed(0) ?? 'N/A'}',
            ),
            _buildRow(
              'assets/logos/bottle.svg',
              'Milk Powder',
              ' = ${historyData.poundsOfMilkReplacer?.toStringAsFixed(0) ?? 'N/A'}',
            ),
            _buildRow(
              'assets/logos/bottleMed.svg',
              'Water + Milk Powder',
              ' = ${historyData.solidsHospitalMilk?.toStringAsFixed(0) ?? 'N/A'}',
            ),
            _buildRow(
              'assets/logos/bottleMed.svg',
              'Hospital Milk Used',
              ' = ${historyData.hospitalMilkUsed?.toStringAsFixed(0) ?? 'N/A'}',
            ),
            Divider(color: Colors.grey.shade300, thickness: 1, height: 15.h),
            _buildRow(
              null,
              'Total Volume',
              historyData.totalVolume ?? 'N/A',
              bold: true,
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAEFE4),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/logos/close.svg',
                            height: 20.h,
                            width: 20.h,
                            color: AppColors.textPrimary,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Close',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15.w),

                Expanded(
                  child: GestureDetector(
                    onTap: () => _copyRecipeSummary(),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE4EDFA),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/logos/copy.svg',
                            height: 16.h,
                            width: 16.h,
                            color: AppColors.textPrimary,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Copy',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(
    String? iconPath,
    String label,
    String value, {
    bool bold = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          if (iconPath != null)
            SvgPicture.asset(iconPath, height: 20.h, width: 20.h),
          if (iconPath != null) SizedBox(width: 8.w),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  void _copyRecipeSummary() {
    if (historyData == null) return;

    final summary = '''
Recipe Summary - ${historyData.createdAt != null ? _formatDateForCopy(historyData!.createdAt!) : 'N/A'}

Bottle Information:
• Number of Bottles: ${historyData.numberOfBottles ?? 'N/A'}
• Bottle Size: ${historyData.bottleSize?.toStringAsFixed(2) ?? 'N/A'} ml

Hospital Milk Details:
• Hospital Milk Volume: ${historyData.hospitalMilkVolume?.toStringAsFixed(2) ?? 'N/A'} lbs
• Solids in Hospital Milk: ${historyData.solidsHospitalMilk?.toStringAsFixed(2) ?? 'N/A'}%
• Hospital Milk Used: ${historyData.hospitalMilkUsed?.toStringAsFixed(2) ?? 'N/A'} lbs

Calculation Results:
• Desired Solids Content: ${historyData.desiredSolidsContent?.toStringAsFixed(2) ?? 'N/A'}%
• Pounds of Water: ${historyData.poundsOfWater?.toStringAsFixed(2) ?? 'N/A'} lbs
• Pounds of Milk Replacer: ${historyData.poundsOfMilkReplacer?.toStringAsFixed(2) ?? 'N/A'} lbs

Total Volume: ${historyData.totalVolume ?? 'N/A'}

Generated on: ${DateTime.now().toString()}
''';

    Clipboard.setData(ClipboardData(text: summary));
    Get.snackbar(
      'Copied!',
      'Recipe summary copied to clipboard',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
    );
  }

  String _formatDateForCopy(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateString;
    }
  }
}
