import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/view/widget/history_wigets.dart';

class HistoryItem {
  final String number;
  final String volume;
  final String date;
  final String time;

  HistoryItem({
    required this.number,
    required this.volume,
    required this.date,
    required this.time,
  });
}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  static final List<HistoryItem> _historyItems = [
    HistoryItem(
      number: '01',
      volume: '1500',
      date: '06-7-25',
      time: '10:30 AM',
    ),
    HistoryItem(
      number: '02',
      volume: '1500',
      date: '06-7-25',
      time: '10:32 AM',
    ),
    HistoryItem(
      number: '03',
      volume: '1500',
      date: '06-9-25',
      time: '10:30 AM',
    ),
    HistoryItem(
      number: '04',
      volume: '1500',
      date: '06-7-25',
      time: '10:30 AM',
    ),
    HistoryItem(
      number: '05',
      volume: '1500',
      date: '06-12-25',
      time: '10:30 AM',
    ),
    HistoryItem(
      number: '06',
      volume: '1500',
      date: '06-7-25',
      time: '10:30 AM',
    ),
    HistoryItem(
      number: '07',
      volume: '1500',
      date: '06-7-25',
      time: '10:30 AM',
    ),
    HistoryItem(
      number: '08',
      volume: '1500',
      date: '06-7-25',
      time: '10:30 AM',
    ),
  ];

  void _clearHistory() {
    print('History cleared');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'history'.tr,
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        '${_historyItems.length} ${'calculations'.tr}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: _clearHistory,
                    child: Container(
                      height: 36.h,
                      width: 90.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFD96346), width: 1),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/logos/trash.svg'),
                          SizedBox(width: 9.w),
                          Text(
                            'clear'.tr,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFD96346),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _historyItems.length,
                itemBuilder: (context, index) {
                  final item = _historyItems[index];
                  return HistoryTile(
                    number: item.number,
                    volume: item.volume,
                    date: item.date,
                    time: item.time,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
