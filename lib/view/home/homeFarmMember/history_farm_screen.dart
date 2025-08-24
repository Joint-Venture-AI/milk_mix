import 'package:flutter/material.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/view/home/history/history_list_widget.dart';

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

class HistoryFarmScreen extends StatelessWidget {
  const HistoryFarmScreen({super.key});

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
      body: HistoryListWidget(),
    );
  }
}
