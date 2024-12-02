// import 'package:flutter/material.dart';

class SleepPlanController {
  // Example sleep plans for specific dates
  final Map<DateTime, String> sleepPlans = {
    //DateTime.now().add(Duration(days: 1)) termasuk hour minutes dan second makanya ga muncul
    DateTime(2024, 11, 30): "Sleep at 10 PM, Wake up at 6 AM", // Example for today
    DateTime(2024, 12, 1): "Sleep at 11 PM, Wake up at 7 AM", // Example for tomorrow
  };

  // Method to get sleep plan for a specific date
  String? getSleepPlan(DateTime date) {
    // Normalize the date to ignore time for comparison
    DateTime normalizedDate = DateTime(date.year, date.month, date.day);
    return sleepPlans[normalizedDate];
  }
}