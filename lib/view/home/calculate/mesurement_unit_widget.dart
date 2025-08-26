// lib/view/widget/measurement_unit_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/view/home/calculate/mesurement_units.dart';

class MeasurementUnitWidget extends StatefulWidget {
  final MeasurementSystem measurementSystem;
  final dynamic selectedUnit;
  final Function(MeasurementSystem, dynamic) onUnitChanged;

  const MeasurementUnitWidget({
    super.key,
    required this.measurementSystem,
    required this.selectedUnit,
    required this.onUnitChanged,
  });

  @override
  State<MeasurementUnitWidget> createState() => _MeasurementUnitWidgetState();
}

class _MeasurementUnitWidgetState extends State<MeasurementUnitWidget> {
  bool isDropdownExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.lightGrey),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isDropdownExpanded = !isDropdownExpanded;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 48.h),
                SvgPicture.asset('assets/logos/scale.svg', height: 18.h),
                SizedBox(width: 8.w),
                Text(
                  'measurementUnits'.tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Spacer(),
                SvgPicture.asset(
                  isDropdownExpanded
                      ? 'assets/logos/up.svg'
                      : 'assets/logos/down.svg',
                  height: 24.h,
                ),
              ],
            ),
          ),
          if (isDropdownExpanded) ...[
            SizedBox(height: 8.h),
            _buildMainUnitToggle(),
            SizedBox(height: 8.h),
            _buildSubUnitToggle(),
            SizedBox(height: 8.h),
          ],
        ],
      ),
    );
  }

  Widget _buildMainUnitToggle() {
    return Container(
      padding: EdgeInsets.all(5.h),
      decoration: BoxDecoration(
        color: AppColors.shade,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          _buildToggleButton(
            value: MeasurementSystem.imperial,
            label: MeasurementSystem.imperial.displayName,
            isSelected: widget.measurementSystem == MeasurementSystem.imperial,
            onTap: () {
              widget.onUnitChanged(
                MeasurementSystem.imperial,
                ImperialUnit.gallon,
              );
            },
          ),
          SizedBox(width: 8.w),
          _buildToggleButton(
            value: MeasurementSystem.metric,
            label: MeasurementSystem.metric.displayName,
            isSelected: widget.measurementSystem == MeasurementSystem.metric,
            onTap: () {
              widget.onUnitChanged(MeasurementSystem.metric, MetricUnit.liter);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSubUnitToggle() {
    return Container(
      padding: EdgeInsets.all(5.h),
      decoration: BoxDecoration(
        color: AppColors.shade,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children:
            widget.measurementSystem == MeasurementSystem.imperial
                ? [
                  _buildToggleButton(
                    value: ImperialUnit.gallon,
                    label: ImperialUnit.gallon.displayName,
                    isSelected: widget.selectedUnit == ImperialUnit.gallon,
                    onTap: () {
                      widget.onUnitChanged(
                        widget.measurementSystem,
                        ImperialUnit.gallon,
                      );
                    },
                  ),
                  SizedBox(width: 8.w),
                  _buildToggleButton(
                    value: ImperialUnit.pounds,
                    label: ImperialUnit.pounds.displayName,
                    isSelected: widget.selectedUnit == ImperialUnit.pounds,
                    onTap: () {
                      widget.onUnitChanged(
                        widget.measurementSystem,
                        ImperialUnit.pounds,
                      );
                    },
                  ),
                ]
                : [
                  _buildToggleButton(
                    value: MetricUnit.liter,
                    label: MetricUnit.liter.displayName,
                    isSelected: widget.selectedUnit == MetricUnit.liter,
                    onTap: () {
                      widget.onUnitChanged(
                        widget.measurementSystem,
                        MetricUnit.liter,
                      );
                    },
                  ),
                  SizedBox(width: 8.w),
                  _buildToggleButton(
                    value: MetricUnit.kilo,
                    label: MetricUnit.kilo.displayName,
                    isSelected: widget.selectedUnit == MetricUnit.kilo,
                    onTap: () {
                      widget.onUnitChanged(
                        widget.measurementSystem,
                        MetricUnit.kilo,
                      );
                    },
                  ),
                ],
      ),
    );
  }

  Widget _buildToggleButton({
    required dynamic value,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(5.r),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.primary : AppColors.textGrey,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
    );
  }
}
