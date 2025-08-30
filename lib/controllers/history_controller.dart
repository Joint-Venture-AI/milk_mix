import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:milk_mix/data_source/api/provider/api_provider.dart';
import 'package:milk_mix/model/get_milk_history_response.dart';
// Added for Get.snackbar

class HistoryController extends GetxController {
  final ApiProvider _apiService = ApiProvider.instance;

  // Observable variables
  final RxList<GetMilkHistoryData> historyList = <GetMilkHistoryData>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMilkHistory();
  }

  Future<void> fetchMilkHistory() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';
      final result = await _apiService.milkHistory.getMilkHistory();

      if (result.isSuccess) {
        historyList.value = result.data ?? [];
      } else {
        hasError.value = true;
        errorMessage.value = result.error ?? 'Failed to fetch history';
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'An error occurred: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshHistory() async {
    await fetchMilkHistory();
  }

  void clearHistory() {
    historyList.clear();
    // Note: You might want to add an API call to clear history on the server
  }

  Future<void> clearHistoryFromServer() async {
    try {
      final result = await _apiService.milkHistory.clearMilkHistory();
      if (result.isSuccess) {
        historyList.clear();
        Get.snackbar(
          'Success',
          'History cleared successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to clear history: ${result.error}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      }
    } catch (e) {
      debugPrint('Error clearing history: $e');
      Get.snackbar(
        'Error',
        'An error occurred while clearing history',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    }
  }

  // GetMilkHistoryData? getHistoryById(int id) {
  //   try {
  //     return historyList.firstWhere((history) => history.id == id);
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // List<GetMilkHistoryData> getHistoryByDate(String date) {
  //   return historyList
  //       .where((history) => history.createdAt?.contains(date) ?? false)
  //       .toList();
  // }

  int get totalCalculations => historyList.length;

  // Get filtered history by date range
  // List<GetMilkHistoryData> getHistoryByDateRange(
  //   DateTime startDate,
  //   DateTime endDate,
  // ) {
  //   return historyList.where((history) {
  //     if (history.createdAt == null) return false;
  //     try {
  //       final historyDate = DateTime.parse(history.createdAt!);
  //       return historyDate.isAfter(startDate.subtract(Duration(days: 1))) &&
  //           historyDate.isBefore(endDate.add(Duration(days: 1)));
  //     } catch (e) {
  //       return false;
  //     }
  //   }).toList();
  // }

  // Get sorted history (newest first)
  List<GetMilkHistoryData> getSortedHistory() {
    final sortedList = List<GetMilkHistoryData>.from(historyList);
    sortedList.sort((a, b) {
      if (a.createdAt == null || b.createdAt == null) return 0;
      try {
        final dateA = DateTime.parse(a.createdAt!);
        final dateB = DateTime.parse(b.createdAt!);
        return dateB.compareTo(dateA); // Newest first
      } catch (e) {
        return 0;
      }
    });
    return sortedList;
  }

  // Get statistics
  // Map<String, dynamic> getHistoryStatistics() {
  //   if (historyList.isEmpty) {
  //     return {
  //       'totalCalculations': 0,
  //       'averageBottleSize': 0.0,
  //       'totalVolume': 0.0,
  //       'dateRange': 'No data',
  //     };
  //   }

  //   final totalVolume = historyList.fold<double>(
  //     0.0,
  //     (sum, history) =>
  //         sum + (history.bottleSize ?? 0) * (history.numberOfBottles ?? 0),
  //   );

  //   final averageBottleSize =
  //       historyList.fold<double>(
  //         0.0,
  //         (sum, history) => sum + (history.bottleSize ?? 0),
  //       ) /
  //       historyList.length;

  //   String dateRange = 'No data';
  //   if (historyList.isNotEmpty) {
  //     try {
  //       final dates =
  //           historyList
  //               .where((h) => h.createdAt != null)
  //               .map((h) => DateTime.parse(h.createdAt!))
  //               .toList();
  //       if (dates.isNotEmpty) {
  //         dates.sort();
  //         final firstDate = dates.first;
  //         final lastDate = dates.last;
  //         dateRange =
  //             '${formatDate(firstDate.toString())} - ${formatDate(lastDate.toString())}';
  //       }
  //     } catch (e) {
  //       dateRange = 'Date parsing error';
  //     }
  //   }

  //   return {
  //     'totalCalculations': historyList.length,
  //     'averageBottleSize': averageBottleSize,
  //     'totalVolume': totalVolume,
  //     'dateRange': dateRange,
  //   };
  // }

  // Format date for display
  String formatDate(String? dateString) {
    if (dateString == null) return '';
    try {
      final date = DateTime.parse(dateString).toLocal();
      return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateString;
    }
  }

  // Format time for display
  String formatTime(String? dateString) {
    if (dateString == null) return '';
    try {
      final date = DateTime.parse(dateString).toLocal();
      final hour = date.hour;
      final minute = date.minute;
      final period = hour >= 12 ? 'PM' : 'AM';
      final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
      return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
    } catch (e) {
      return '';
    }
  }

  // Get total volume for a history item
  String getTotalVolume(GetMilkHistoryData history) {
    if (history.totalVolume != null) {
      return history.totalVolume!;
    }

    // Calculate total volume if not provided
    final bottleSize = history.bottleSize ?? 0;
    final numberOfBottles = history.numberOfBottles ?? 0;
    final total = bottleSize * numberOfBottles;
    return '${total.toStringAsFixed(0)} ml';
  }

  String getWeekDayName(String? dateString) {
    try {
      final date = DateTime.parse(dateString ?? '').toLocal();
      return DateFormat('EEE').format(date).toUpperCase();
    } catch (e) {
      return '';
    }
  }
}
