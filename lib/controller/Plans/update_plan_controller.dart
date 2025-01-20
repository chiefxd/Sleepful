import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../services/notification_service.dart';
import '../../services/alarm_service.dart';
import '../../view/Pages/Plans/view_plans.dart';

void alarmCallback() {
  print("🚨 Alarm Triggered: End Time Reached! 🚨");
  NotificationService().playCustomAlarm(
    "End Time Alert",
    "Your specified end time has been reached.",
    "custom_alarm", // Name of the MP3 file in the `android/app/src/main/res/raw` directory
  );
}

class TimePickerController {
  int selectedHour;
  int selectedMinute;
  String selectedPeriod;
  List<bool> selectedDays;

  // Store selected times for start and end
  String startTime;
  String endTime;

  bool isStartSelected = true; // Track which button is selected
  String successMessage = '';

  final List<int> hours = List.generate(12, (index) => index + 1);
  final List<int> minutes = List.generate(60, (index) => index);
  final List<String> periods = ['AM', 'PM'];

  // final FixedExtentScrollController hourController =
  // FixedExtentScrollController(initialItem: 12 + 5999);
  // final FixedExtentScrollController minuteController =
  // FixedExtentScrollController(initialItem: 0 + 6000);
  // final FixedExtentScrollController periodController =
  // FixedExtentScrollController(initialItem: 0);
  final FixedExtentScrollController hourController;
  final FixedExtentScrollController minuteController;
  final FixedExtentScrollController periodController;

  TimePickerController({
    required this.startTime, // Required start time
    required this.endTime, // Required end time
    List<bool>? selectedDays, // Optional selected days
  })  : selectedDays = selectedDays ??
            List.generate(7, (index) => false), // Initialize selectedDays
        selectedHour = int.parse(
            startTime.split(':')[0]), // Initialize selectedHour from startTime
        selectedMinute = int.parse(startTime
            .split(':')[1]
            .split(' ')[0]), // Initialize selectedMinute from startTime
        selectedPeriod = startTime.split(' ')[1],
        hourController = FixedExtentScrollController(
            initialItem: _getHourIndex(startTime) + 6000),
        minuteController = FixedExtentScrollController(
            initialItem: _getMinuteIndex(startTime) + 6000),
        periodController = FixedExtentScrollController(
            initialItem: _getPeriodIndex(startTime));

  // Helper methods to get the initial index for hour, minute, and period
  static int _getHourIndex(String time) {
    int hour = int.parse(time.split(':')[0]);
    return hour == 12 ? 0 : hour - 1; // Adjust for 12-hour format
  }

  static int _getMinuteIndex(String time) {
    return int.parse(time.split(':')[1].split(' ')[0]);
  }

  static int _getPeriodIndex(String time) {
    String period = time.split(' ')[1];
    return period == 'AM' ? 0 : 1; // 0 for AM, 1 for PM
  }

  void switchToStart() {
    if (!isStartSelected) {
      endTime =
          '${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')} $selectedPeriod';
      resetTime(true);
    } else {
      resetTime(true);
    }
    isStartSelected = true;
  }

  void switchToEnd() {
    if (isStartSelected) {
      startTime =
          '${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')} $selectedPeriod';
      resetTime(false);
    } else {
      resetTime(false);
    }
    isStartSelected = false;
  }

  Future<void> _updatePlanToFirestore(String planId, String title,
      String startTime, String endTime, List<String> selectedDays) async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Reference to the Firestore collection
      DocumentReference planDocument = FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection('Plans')
          .doc(planId);

      // Update the document with the provided data
      await planDocument.update({
        'title': title,
        'startTime': startTime,
        'endTime': endTime,
        'selectedDays': selectedDays,
        'isCalendar': false,
        'updatedAt': FieldValue
            .serverTimestamp(), // Optional: Add a timestamp for the update
      });
    }
  }

  Future<bool> _checkForDuplicateTitle(String title, String planId) async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Reference to the Firestore collection
      CollectionReference plansCollection = FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection('Plans');

      // Query for plans with the same title, excluding the current planId
      QuerySnapshot querySnapshot = await plansCollection
          .where('title', isEqualTo: title)
          .where(FieldPath.documentId,
              isNotEqualTo: planId) // Exclude the current planId
          .get();

      // Check if any plans with the same title exist
      return querySnapshot.docs.isNotEmpty;
    }

    return false;
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Color(0xFF979797),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> validateTimes(
      BuildContext context, String title, String planId) async {
    if (title.isEmpty) {
      showToast("Plan title cannot be empty.");
      return;
    }

    bool isDuplicate = await _checkForDuplicateTitle(title, planId);
    if (isDuplicate) {
      showToast("Plan title already exists. Please choose a different title.");
      return;
    }

    if (!selectedDays.any((day) => day)) {
      showToast("Please select at least one day.");
      return;
    }

    if (isStartSelected) {
      startTime =
      '${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')} $selectedPeriod';
    } else {
      endTime =
      '${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')} $selectedPeriod';
    }

    DateTime today = DateTime.now();
    DateTime updatedAt = DateTime.now();

    DateTime startDateTime = _parseTime(startTime, date: today);
    DateTime endDateTime = _parseTime(endTime, date: today);

    if (endDateTime.isBefore(startDateTime)) {
      endDateTime = endDateTime.add(Duration(days: 1));
    }

    print('Start DateTime: $startDateTime');
    print('End DateTime: $endDateTime');

    Duration duration = endDateTime.difference(startDateTime);

    if (startDateTime.isAtSameMomentAs(endDateTime)) {
      showToast("Start time and end time cannot be the same.");
      return;
    }

    if (duration.inMinutes < 2) {
      showToast("Minimum duration of sleep is 30 minutes.");
      return;
    }

    if (duration.inHours > 9 ||
        (duration.inHours == 9 && duration.inMinutes.remainder(60) > 0)) {
      showToast("Maximum duration of sleep is 9 hours.");
      return;
    }

    List<String> selectedDayLetters = [];
    List<String> fullDayNames = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];

    final alarmService = AlarmService();
    List<Map<String, dynamic>> visiblePlans = [];

    for (int i = 0; i < selectedDays.length; i++) {
      if (selectedDays[i]) {
        selectedDayLetters.add(fullDayNames[i]);
        DateTime startNotificationTime = DateTime(
          today.year,
          today.month,
          today.day,
          startDateTime.hour,
          startDateTime.minute,
        ).subtract(Duration(minutes: 2)); // 5 minutes before start time

        print('Start Notification Time: $startNotificationTime');
        print('Current Time: $today');

        if (i == today.weekday % 7) {
          // If today is the selected day
          if (updatedAt.isBefore(startNotificationTime)) {
            final notificationService = NotificationService();
            print(
                'Scheduling notification for time: $startNotificationTime'); // Debugging line
            await notificationService.scheduleNotification(
              title.hashCode ^ i, // Unique ID for each day
              title,
              startNotificationTime,
            );

            DateTime currentDate = DateTime.now();
            DateTime alarmTime = DateTime(
              currentDate.year,
              currentDate.month,
              currentDate.day,
              endDateTime.hour,
              endDateTime.minute,
            );
            // if (today.isAtSameMomentAs(endDateTime) || today.isAfter(endAlarmTime)) {
            if (alarmTime.isAfter(currentDate)) {
              print('Triggering alarm callback for end time at $alarmTime');
              await alarmService.scheduleAlarm(
                id: i + 1000, // Unique ID for alarm
                triggerTime: alarmTime,
                callback: alarmCallback,
              );
            }
          }
        }
      }
    }

    // Schedule alarms only for visible plans
    for (var plan in visiblePlans) {
      DateTime alarmTime = DateTime(
        today.year,
        today.month,
        today.day,
        plan['endTime'].hour,
        plan['endTime'].minute,
      );

      if (alarmTime.isAfter(today)) {
        print('Scheduling alarm for ${plan['title']} at $alarmTime');
        await alarmService.scheduleAlarm(
          id: plan['dayIndex'] + 1000, // Unique ID for alarm
          triggerTime: alarmTime,
          callback: alarmCallback,
        );
      } else {
        print('Alarm time is not in the future, skipping scheduling.');
      }
    }

    if (selectedDayLetters.isNotEmpty) {
      showToast(
          'Success! "$title", Your sleep duration is valid. Selected days: ${selectedDayLetters.join(', ')}.');
    } else {
      showToast(
          'Success! "$title", Your sleep duration is valid. No days selected.');
    }

    await _updatePlanToFirestore(
        planId, title, startTime, endTime, selectedDayLetters);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ViewPlans()),
    );
  }


  void resetTime(bool isStart) {
    if (isStart) {
      // Reset to the last selected start time
      List<String> startParts = startTime.split(':');
      selectedHour = int.parse(startParts[0]);
      selectedMinute = int.parse(startParts[1].split(' ')[0]);
      selectedPeriod = startParts[1].split(' ')[1];
      hourController
          .jumpToItem((selectedHour) + 5999); // Update the hour controller
      minuteController
          .jumpToItem(selectedMinute + 6000); // Update the minute controller
      periodController.jumpToItem(
          periods.indexOf(selectedPeriod)); // Update the period controller
    } else {
      // Reset to the last selected end time
      List<String> endParts = endTime.split(':');
      selectedHour = int.parse(endParts[0]);
      selectedMinute = int.parse(endParts[1].split(' ')[0]);
      selectedPeriod = endParts[1].split(' ')[1];
      hourController
          .jumpToItem((selectedHour) + 5999); // Update the hour controller
      minuteController
          .jumpToItem(selectedMinute + 6000); // Update the minute controller
      periodController.jumpToItem(
          periods.indexOf(selectedPeriod)); // Update the period controller
    }
  }

  // DateTime _parseTime(String time) {
  //   List<String> parts = time.split(':');
  //   int hour = int.parse(parts[0]);
  //   int minute = int.parse(parts[1].split(' ')[0]);
  //   String period = parts[1].split(' ')[1];
  //
  //   if (period == 'PM' && hour != 12) {
  //     hour += 12;
  //   } else if (period == 'AM' && hour == 12) {
  //     hour = 0;
  //   }
  //
  //   return DateTime(0, 1, 1, hour, minute);
  // }
  DateTime _parseTime(String time, {DateTime? date}) {
    List<String> parts = time.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1].split(' ')[0]);
    String period = parts[1].split(' ')[1];

    if (period == 'PM' && hour != 12) {
      hour += 12;
    } else if (period == 'AM' && hour == 12) {
      hour = 0;
    }

    date ??= DateTime.now(); // Use current date if no date is provided
    // return DateTime(0, 1, 1, hour, minute);
    return DateTime(date.year, date.month, date.day, hour, minute);
  }
}
