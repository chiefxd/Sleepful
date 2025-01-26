import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../providers/user_data_provider.dart';

class SleepPlanController {
  Map<DateTime, List<Map<String, dynamic>>> sleepPlans = {};

  Timer? periodicChecker;

  SleepPlanController() {
    // Start periodic checks for end times
    periodicChecker = Timer.periodic(Duration(minutes: 5), (_) async {
      _checkAndMoveToSuccessfulPlans();
    });
  }

  Stream<Map<DateTime, List<Map<String, dynamic>>>> fetchSleepPlans(
      String userId) {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Plans')
        .snapshots()
        .asyncMap((snapshot) async {
      // Clear previous plans
      sleepPlans.clear();
      DateTime today = DateTime.now();
      // print('Fetching plans for today: $today');

      // Fetch plans from the "Plans" collection
      await _fetchPlansFromCollection(snapshot.docs, today, userId, 'Plans');

      // Fetch plans from the "Calendar Plans" collection
      QuerySnapshot calendarPlansSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('Calendar Plans')
          .get();

      await _fetchCalendarPlans(calendarPlansSnapshot.docs, today, userId);

      // print("All Sleep Plans: $sleepPlans"); // Debugging: Print all sleep plans
      return sleepPlans; // Return the updated sleepPlans map
    });
  }

  Future<void> _fetchPlansFromCollection(List<QueryDocumentSnapshot> docs,
      DateTime today, String userId, String collectionName) async {
    for (var doc in docs) {
      final plan = doc.data() as Map<String, dynamic>;
      final planId = doc.id; // Get the planId
      final selectedDays = List<String>.from(plan['selectedDays'] ?? []);
      final startTime = plan['startTime'];
      final endTime = plan['endTime'];
      final title = plan['title'];
      final isCalendar = plan['isCalendar'];
      final createdAt = (plan['createdAt'] as Timestamp).toDate();
      final notVisibleCalendar = plan['notVisibleCalendar'] != null
          ? (plan['notVisibleCalendar'] as Timestamp).toDate()
          : null;
      print(
          'Plan Title: $title, Created At: $createdAt, Plan ID: $planId, Start Time: $startTime, End Time: $endTime, isCalendar: $isCalendar, Collection: $collectionName'); // Debugging line

      DateTime startDateTime = _parseTime(today, startTime);

      for (String day in selectedDays) {
        for (DateTime date in _getAllDatesForDay(day)) {

          DateTime normalizedDate = DateTime(date.year, date.month, date.day);
          DateTime? normalizedNotVisibleDate = notVisibleCalendar != null
              ? DateTime(notVisibleCalendar.year, notVisibleCalendar.month, notVisibleCalendar.day)
              : null;

          // Skip if the normalized date matches the notVisibleCalendar date
          if (normalizedNotVisibleDate != null &&
              normalizedDate.isAtSameMomentAs(normalizedNotVisibleDate)) {
            continue; // Skip this date
          }

          // Allow the plan to show if createdAt is before startTime on the same day
          if ((date.isBefore(createdAt) &&
              createdAt.isAfter(_parseTime(date, startTime)))) {
            continue; // Skip this date
          }

          DateTime startDateTimeRill = _parseTime(date, startTime);
          DateTime endDateTimeRill = _parseTime(date, endTime);

          // Check if the plan's createdAt is before or at the start time
          if (createdAt.isBefore(startDateTime) ||
              createdAt.isAtSameMomentAs(startDateTime)) {
            // Add the plan for the current date
            if (!sleepPlans.containsKey(date)) {
              sleepPlans[date] = [];
            }
            sleepPlans[date]!.add({
              'title': title,
              'startTime': startDateTimeRill,
              'endTime': endDateTimeRill,
              'planData': plan,
              'planId': planId, // Include the planId
              'selectedDays': selectedDays, // Include selectedDays
              'userId': userId,
              'collection':
              collectionName, // Indicate which collection the plan came from
              'isCalendar': isCalendar,
              'notVisibleCalendar': notVisibleCalendar,
            });
            // print("Added Plan: $title from $startDateTimeRill to $endTime on $date and createdAt: $createdAt");
          } else {
            // If createdAt is after startTime, add the plan for the next occurrence of the selected day
            DateTime nextOccurrence =
            date.add(Duration(days: 0)); // Move to the next week
            if (!sleepPlans.containsKey(nextOccurrence)) {
              sleepPlans[nextOccurrence] = [];
            }
            sleepPlans[nextOccurrence]!.add({
              'title': title,
              'startTime': startDateTimeRill,
              'endTime': endDateTimeRill,
              'planData': plan,
              'planId': planId, // Include the planId
              'selectedDays': selectedDays, // Include selectedDays
              'userId': userId,
              'collection': collectionName,
              'isCalendar': isCalendar,
              'notVisibleCalendar': notVisibleCalendar,
            });
            // print("Added Plan: $title for next occurrence on $nextOccurrence and createdAt: $createdAt");
          }
        }
      }
    }
  }

  Future<void> _fetchCalendarPlans(List<QueryDocumentSnapshot> docs, DateTime today, String userId) async {
    for (var doc in docs) {
      final plan = doc.data() as Map<String, dynamic>;
      final planId = doc.id; // Get the planId
      final selectedDate = (plan['selectedDate'] as Timestamp).toDate(); // Get the selectedDate
      final startTime = plan['startTime'];
      final endTime = plan['endTime'];
      final title = plan['title'];
      final isCalendar = plan['isCalendar'];
      // final createdAt = (plan['createdAt'] as Timestamp).toDate();
      final notVisibleCalendar = plan['notVisibleCalendar']; // Get the notVisibleCalendar field

      DateTime startDateTime = _parseTime(selectedDate, startTime);
      DateTime endDateTime = _parseTime(selectedDate, endTime);

      DateTime normalizedDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

      // Only add the plan if the selectedDate matches today
      // if (selectedDate.year == today.year &&
      //     selectedDate.month == today.month &&
      //     selectedDate.day == today.day) {
        // Check if the date is in notVisibleCalendar
        if (notVisibleCalendar != null && normalizedDate.isAtSameMomentAs(notVisibleCalendar)) {
          continue; // Skip this date
        }

        if (!sleepPlans.containsKey(normalizedDate)) {
          sleepPlans[normalizedDate] = [];
        }
        sleepPlans[normalizedDate]!.add({

          'title': title,
          'startTime': startDateTime,
          'endTime': endDateTime,
          'planData': plan,
          'planId': planId, // Include the planId
          'selectedDate': selectedDate, // Include selectedDate
          'userId': userId,
          'collection': 'Calendar Plans', // Indicate this is from Calendar Plans
          'isCalendar': isCalendar,
          'notVisibleCalendar': notVisibleCalendar, // Include notVisibleCalendar
        });
      print('Added Calendar Plan to sleepPlans:');
      print('Title: $title');
      print('Selected Date: $normalizedDate');
      print('Start Time: $startDateTime');
      print('End Time: $endDateTime');
      // }
    }
  }

  Set<String> movedPlanTitles = {};

  void _checkAndMoveToSuccessfulPlans() async {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    print('Current Time: $now');
    DateTime startTime = DateTime.now();

    // for (var date in sleepPlans.keys) {
    if (sleepPlans.containsKey(today)) {
      for (var plan in sleepPlans[today] ?? []) {
        DateTime endDateTime = plan['endTime'];
        String planTitle = plan['title'];

        // Check if the current time is after the end time and the plan hasn't been moved yet
        if (now.isAfter(endDateTime) && !movedPlanTitles.contains(planTitle)) {
          if (plan['notVisibleCalendar'] != null && today.isAtSameMomentAs(plan['notVisibleCalendar'])) {
            continue; // Skip this plan
          }
          print('Moving plan to Successful Plans: ${plan['title']}');
          await _moveToSuccessfulPlans(plan['userId'], plan['planData'], today);
          movedPlanTitles.add(planTitle); // Mark this plan as moved
          DateTime endTime = DateTime.now();
          print(
              'Execution Duration: ${endTime.difference(startTime).inSeconds} seconds');
        } else {
          print('Plan not yet completed or already moved: ${plan['title']}');
          DateTime endTime = DateTime.now();
          print(
              'Execution Duration: ${endTime.difference(startTime).inSeconds} seconds');
        }
      }
    } else {
      print("No plans for today: $today");
    }
  }

  // Method to move the plan to the "Successful Plans" collection
  Future<void> _moveToSuccessfulPlans(
      String userId, Map<String, dynamic> plan, DateTime date) async {
    DateTime endDateTime =
    _parseTime(date, plan['endTime']); // Use the existing _parseTime method

    var existingPlans = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Successful Plans')
        .where('title', isEqualTo: plan['title'])
        .where('successfulDate', isEqualTo: endDateTime)
        .get();

    // Create a new document in the "Successful Plans" collection
    if (existingPlans.docs.isEmpty) {
      try {
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
          'updatedAt': plan.containsKey('updatedAt')
              ? plan['updatedAt']
              : plan['createdAt'], // Add updatedAt field
          'successfulDate': endDateTime, // Use current date
        });

        print('Successfully moved plan to Successful Plans: ${plan['title']}');

        // Award points for completing the plan
        final userDataProvider = UserDataProvider();
        await userDataProvider.fetchAndSetUserData(userId); // Load user data
        userDataProvider.showToast("Congratulations on completing a plan!");
        await userDataProvider
            .awardPointsForPlanCompletion(userId); // Award points
      } catch (e) {
        print('Error moving to successful plans: $e');
      }
    } else {
      print('Plan already exists in Successful Plans: ${plan['title']}');
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
      DateTime date = today.add(
          Duration(days: (targetWeekday - today.weekday + 7) % 7 + (i * 7)));
      allDates
          .add(DateTime(date.year, date.month, date.day)); // Normalize the date
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

  List<String> getSleepPlans(DateTime date) {
    DateTime normalizedDate = DateTime(date.year, date.month, date.day);
    if (sleepPlans.containsKey(normalizedDate)) {
      print("Plans for $normalizedDate: ${sleepPlans[normalizedDate]}"); // Debugging
      return sleepPlans[normalizedDate]!
          .map((plan) =>
      "${plan['title']}: Sleep from ${plan['startTime']} to ${plan['endTime']}")
          .toList();
    }
    print("No plans for $normalizedDate");
    return ["No sleep plan for this date"];
  }
}