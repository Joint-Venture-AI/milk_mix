import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/view/widget/history_wigets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

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

class HistoryFarmScreen extends StatefulWidget {
  const HistoryFarmScreen({super.key});

  @override
  State<HistoryFarmScreen> createState() => _HistoryScreenFarmState();
}

class _HistoryScreenFarmState extends State<HistoryFarmScreen> {
  List<HistoryItem> _historyItems = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchHistoryData();
  }

  Future<void> _fetchHistoryData() async {
    try {
      final baseUrl = 'https://lamprey-included-lion.ngrok-free.app';
      final response = await http.get(Uri.parse('$baseUrl/api/milk-history/'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        setState(() {
          _historyItems =
              jsonData.map((item) {
                final createdAt = DateTime.parse(item['created_at']);
                final dateFormat = DateFormat('MM-d-yy');
                final timeFormat = DateFormat('hh:mm a');
                return HistoryItem(
                  number: item['id'].toString(),
                  volume: item['total_volume'],
                  date: dateFormat.format(createdAt),
                  time: timeFormat.format(createdAt),
                );
              }).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load history: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error fetching history: $e';
        _isLoading = false;
      });
    }
  }

  void _clearHistory() {
    setState(() {
      _historyItems.clear();
    });
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
              if (_isLoading)
                Center(child: CircularProgressIndicator())
              else if (_errorMessage != null)
                Center(
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(fontSize: 16.sp, color: Colors.red),
                  ),
                )
              else
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
