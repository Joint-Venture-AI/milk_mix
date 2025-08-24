import 'package:flutter/material.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/view/home/history/history_list_widget.dart';

//api-done: history screen
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: HistoryListWidget(),
    );
  }
}
