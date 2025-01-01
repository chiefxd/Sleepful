import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class SleepPlanController {
  // Map<DateTime, List<String>> sleepPlans = {};
  Map<DateTime, List<Map<String, dynamic>>> sleepPlans = {};

  Timer? periodicChecker;

  SleepPlanController() {
    // Start periodic checks for end times
    periodicChecker = Timer.periodic(Duration(minutes: 1), (_) {
      _checkAndMoveToSuccessfulPlans();
    });
  }

  // Method to fetch sleep plans from Firestore
  Stream<void> fetchSleepPlans(String userId) {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Plans')
        .snapshots()
        .map((snapshot) {
      sleepPlans.clear(); // Clear previous plans
      for (var doc in snapshot.docs) {
        final plan = doc.data();
        final selectedDays = List<String>.from(plan['selectedDays'] ?? []);
        final startTime = plan['startTime']; // Assuming you have startTime in your plan
        final endTime = plan['endTime']; // Assuming you have endTime in your plan
        final title = plan['title']; // Get the title
        final createdAt = (plan['createdAt'] as Timestamp).toDate(); // Get the creation time

        // Add plans for each selected day
        for (String day in selectedDays) {
          // Get all dates (past and future) for the selected day
          for (DateTime date in _getAllDatesForDay(day)) {
            // Check if the plan was created before the start time of that day
            // DateTime startDateTime = DateTime(date.year, date.month, date.day, int.parse(startTime.split(':')[0]) + (startTime.contains('PM') ? 12 : 0), int.parse(startTime.split(':')[1].split(' ')[0]));
            // DateTime endDateTime = DateTime(date.year, date.month, date.day, int.parse(endTime.split(':')[0]) + (endTime.contains('PM') ? 12 : 0), int.parse(endTime.split(':')[1].split(' ')[0]));
            DateTime startDateTime = _parseTime(date, startTime);
            DateTime endDateTime = _parseTime(date, endTime);

            if (createdAt.isBefore(startDateTime) || date.isAfter(DateTime.now())) {
              // If created before start time or in the future, show the plan
              if (!sleepPlans.containsKey(date)) {
                sleepPlans[date] = []; // Initialize the list if it doesn't exist
              }
              // sleepPlans[date]!.add("$title: Sleep from $startTime to $endTime"); // Add the plan to the list
              sleepPlans[date]!.add({
                'title': title,
                'startTime': startDateTime,
                'endTime': endDateTime,
                'planData': plan,
                'userId': userId,
              });
            }

            // Check if the end time has already been reached for today
            if (date.isAtSameMomentAs(DateTime.now()) && DateTime.now().isAfter(endDateTime)) {
              // Move the plan to the "Successful Plans" collection
              _moveToSuccessfulPlans(userId, plan, date);
            }
          }
        }
      }
    });
  }

  void _checkAndMoveToSuccessfulPlans() async {
    DateTime now = DateTime.now();
    for (var date in sleepPlans.keys) {
      for (var plan in sleepPlans[date] ?? []) {
        DateTime endDateTime = plan['endTime'];
        if (now.isAfter(endDateTime)) {
          await _moveToSuccessfulPlans(plan['userId'], plan['planData'], date);
        }
      }
    }
  }

  // Method to move the plan to the "Successful Plans" collection
  Future<void> _moveToSuccessfulPlans(String userId, Map<String, dynamic> plan, DateTime date) async {
    DateTime endDateTime = _parseTime(date, plan['endTime']); // Use the existing _parseTime method

    var existingPlans = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Successful Plans')
        .where('title', isEqualTo: plan['title'])
        .where('successfulDate', isEqualTo: endDateTime)
        .get();
    // Create a new document in the "Successful Plans" collection
    if (existingPlans.docs.isEmpty) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('Successful Plans')
          .add({
        'createdAt': plan['createdAt'],
        'startTime': plan['startTime'],
        'endTime': plan['endTime'],
        'selectedDays': plan['selectedDays'],
        'title': plan['title'],
        'updatedAt': plan.containsKey('updatedAt') ? plan['updatedAt'] : plan['createdAt'], // Add updatedAt field
        'successfulDate': endDateTime, // Use current date
      });
    }
  }

  DateTime _parseTime(DateTime date, String time) {
    int hour = int.parse(time.split(':')[0]);
    int minute = int.parse(time.split(':')[1].split(' ')[0]);
    if (time.contains('PM') && hour != 12) hour += 12;
    if (time.contains('AM') && hour == 12) hour = 0;
    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  void dispose() {
    periodicChecker?.cancel();
  }

  // Helper method to get all dates (past and future) for a given day of the week
  List<DateTime> _getAllDatesForDay(String day) {
    List<DateTime> allDates = [];
    DateTime today = DateTime.now();
    int targetWeekday = _getWeekdayFromString(day);

    // Loop through the last 7 days and the next 52 weeks to find all occurrences of the target day
    for (int i = -7; i < 52; i++) {
      DateTime date = today.add(Duration(days: (targetWeekday - today.weekday + 7) % 7 + (i * 7)));
      allDates.add(DateTime(date.year, date.month, date.day)); // Normalize the date
    }

    return allDates;
  }

  // Helper method to convert day string to weekday integer
  int _getWeekdayFromString(String day) {
    switch (day.toLowerCase()) {
      case 'monday':
        return DateTime.monday;
      case 'tuesday':
        return DateTime.tuesday;
      case 'wednesday':
        return DateTime.wednesday;
      case 'thursday':
        return DateTime.thursday;
      case 'friday':
        return DateTime.friday;
      case 'saturday':
        return DateTime.saturday;
      case 'sunday':
        return DateTime.sunday;
      default:
        throw Exception('Invalid day: $day');
    }
  }

  // List<String> getSleepPlans(DateTime date) {
  //   DateTime normalizedDate = DateTime(date.year, date.month, date.day);
  //   return sleepPlans[normalizedDate] ?? ["No sleep plan for this date"];
  // }
  List<String> getSleepPlans(DateTime date) {
    DateTime normalizedDate = DateTime(date.year, date.month, date.day);
    if (sleepPlans.containsKey(normalizedDate)) {
      return sleepPlans[normalizedDate]!
          .map((plan) => "${plan['title']}: Sleep from ${plan['startTime']} to ${plan['endTime']}")
          .toList();
    }
    return ["No sleep plan for this date"];
  }
}