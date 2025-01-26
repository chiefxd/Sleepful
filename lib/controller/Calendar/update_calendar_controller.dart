import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sleepful/view/Pages/Calendar/calendar.dart';

import '../../services/notification_service.dart';
import '../../services/alarm_service.dart';
import '../../view/Navbar/bottom_navbar.dart';

void alarmCallback() {
  print("🚨 Alarm Triggered: End Time Reached! 🚨");
  NotificationService().playCustomAlarm(
    "End Time Alert",
    "Your specified end time has been reached.",
    "custom_alarm", // Name of the MP3 file in the `android/app/src/main/res/raw` directory
  );
}

class TimePickerrController {
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

  final FixedExtentScrollController hourController;
  final FixedExtentScrollController minuteController;
  final FixedExtentScrollController periodController;

  TimePickerrController({
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

  // Future<String> _addPlanOrUpdateToCalendar(String title, String startTime, String endTime, List<String> selectedDays) async {
  Future<void> _addPlanOrUpdateToCalendar(String planId, String title, String startTime, String endTime, DateTime selectedDate, bool isCalendar) async {
    User? user = FirebaseAuth.instance.currentUser ;

    if (user != null) {
      if (isCalendar) {
        DocumentReference calendarPlanDocument = FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .collection('Calendar Plans')
            .doc(planId);

        await calendarPlanDocument.update({
          'title': title,
          'startTime': startTime,
          'endTime': endTime,
          'selectedDays': null,
          'isCalendar': true,
          'updatedAt': FieldValue
              .serverTimestamp(), // Optional: Add a timestamp for the update
          'selectedDate': selectedDate,
          'notVisibleCalendar': null,
        });
      }
      // throw Exception("User  not authenticated.");
      else {
        // Move plan from Plans to Calendar Plans
        DocumentReference planDocument = FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .collection('Plans')
            .doc(planId);

        DocumentReference newCalendarPlanDocument = FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .collection('Calendar Plans')
            .doc();

        // Update original plan to mark notVisibleCalendar
        await planDocument.update({
          'notVisibleCalendar': selectedDate,
        });

        // Add to Calendar Plans
        await newCalendarPlanDocument.set({
          'title': title,
          'startTime': startTime,
          'endTime': endTime,
          'selectedDays': null,
          'isCalendar': true,
          'updatedAt': FieldValue.serverTimestamp(),
          'selectedDate': selectedDate,
          'notVisibleCalendar': null,
        });
      }
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

  Future<bool> _checkForDuplicateTitleCalendar(String title, String planId) async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Reference to the Firestore collection
      CollectionReference plansCollection = FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection('Calendar Plans');

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
      BuildContext context, String title, String planId, DateTime selectedDate, bool isCalendar) async {
    User? user = FirebaseAuth.instance.currentUser ;

    if (user == null) {
      showToast("User  not authenticated.");
      return;
    }

    if (title.isEmpty) {
      showToast("Plan title cannot be empty.");
      return;
    }

    bool isDuplicate = await _checkForDuplicateTitle(title, planId);
    if (isDuplicate) {
      showToast("Plan title already exists. Please choose a different title.");
      return;
    }

    bool isDuplicateCalendar = await _checkForDuplicateTitleCalendar(title, planId);
    if (isDuplicateCalendar) {
      showToast("Plan title already exists. Please choose a different title.");
      return;
    }

    if (isStartSelected) {
      startTime =
      '${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')} $selectedPeriod';
    } else {
      endTime =
      '${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')} $selectedPeriod';
    }

    DateTime startDateTime = _parseTime(startTime);
    DateTime endDateTime = _parseTime(endTime);

    if (endDateTime.isBefore(startDateTime)) {
      endDateTime = endDateTime.add(Duration(days: 1));
    }

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

    // Get today's day of the week
    DateTime startNotificationTime = startDateTime.subtract(Duration(minutes: 2)); // 2 minutes before start time
    DateTime currentDate = DateTime.now();

    // Schedule the notification
    if (startNotificationTime.isAfter(currentDate)) {
      final notificationService = NotificationService();
      print('Scheduling notification for time: $startNotificationTime');
      await notificationService.scheduleNotification(
        title.hashCode, // Unique ID for the notification
        title,
        startNotificationTime,
      );

      // Schedule the alarm
      if (endDateTime.isAfter(currentDate)) {
        print('Triggering alarm callback for end time at $endDateTime');
        final alarmService = AlarmService();
        await alarmService.scheduleAlarm(
          id: 1000, // Unique ID for alarm
          triggerTime: endDateTime,
          callback: alarmCallback,
        );
      }
    }

    showToast('Success! "$title", Your sleep duration is valid.');

    await _addPlanOrUpdateToCalendar(planId, title, startTime, endTime, selectedDate, isCalendar);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Calendar(userId: userId ?? '')),
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

  DateTime _parseTime(String time) {
    List<String> parts = time.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1].split(' ')[0]);
    String period = parts[1].split(' ')[1];

    if (period == 'PM' && hour != 12) {
      hour += 12;
    } else if (period == 'AM' && hour == 12) {
      hour = 0;
    }

    return DateTime(0, 1, 1, hour, minute);
  }
}
