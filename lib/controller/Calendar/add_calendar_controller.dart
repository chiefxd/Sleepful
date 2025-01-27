import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../services/notification_service.dart';
import '../../services/alarm_service.dart';
import '../../view/Navbar/bottom_navbar.dart';
import '../../view/Pages/Calendar/calendar.dart';
// import '../../view/Pages/Plans/view_plans.dart';

void alarmCallback() {
  print("🚨 Alarm Triggered: End Time Reached! 🚨");
  NotificationService().playCustomAlarm(
    "End Time Alert",
    "Your specified end time has been reached.",
    "custom_alarm", // Name of the MP3 file in the `android/app/src/main/res/raw` directory
  );
}

class TimePickerrController {
  int selectedHour = 12; // Default hour
  int selectedMinute = 0; // Default minute
  String selectedPeriod = 'AM';

  // Store selected times for start and end
  String startTime = '12:00 AM';
  String endTime = '12:00 AM';

  bool isStartSelected = true; // Track which button is selected
  String successMessage = '';

  final List<int> hours = List.generate(12, (index) => index + 1);
  final List<int> minutes = List.generate(60, (index) => index);
  final List<String> periods = ['AM', 'PM'];
  List<bool> selectedDays = List.generate(7, (index) => false);

  // Use FixedExtentScrollController
  final FixedExtentScrollController hourController =
  FixedExtentScrollController(initialItem: 12 + 5999);
  final FixedExtentScrollController minuteController =
  FixedExtentScrollController(initialItem: 0 + 6000);
  final FixedExtentScrollController periodController =
  FixedExtentScrollController(initialItem: 0);

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

  Future<String> _addCalendarToFirestore(String title, String startTime,
      String endTime, DateTime selectedDate) async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser ;

    if (user != null) {
      // Reference to the Firestore collection
      CollectionReference calendarCollection = FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection('Calendar Plans');

      DocumentReference docRef = await calendarCollection.add({
        'title': title,
        'startTime': startTime,
        'endTime': endTime,
        'selectedDays': null,
        'isCalendar': true,
        'createdAt': FieldValue.serverTimestamp(),
        'selectedDate': selectedDate,
        'notVisibleCalendar': null,
      });
      return docRef.id;
    }
    throw Exception("User  not authenticated.");
  }

  Future<bool> _checkForDuplicateTitle(String title) async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser ;

    if (user != null) {
      // Reference to the Firestore collection
      CollectionReference plansCollection = FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection('Plans');

      // Query for plans with the same title
      QuerySnapshot querySnapshot =
      await plansCollection.where('title', isEqualTo: title).get();

      // Check if any plans with the same title exist
      return querySnapshot.docs.isNotEmpty;
    }

    return false;
  }

  Future<bool> _checkForDuplicateTitleCalendar(String title) async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser ;

    if (user != null) {
      // Reference to the Firestore collection
      CollectionReference plansCollection = FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection('Calendar Plans');

      // Query for plans with the same title
      QuerySnapshot querySnapshot =
      await plansCollection.where('title', isEqualTo: title).get();

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
      backgroundColor: Color (0xFF979797),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> validateTimes(BuildContext context, String title, DateTime selectedDate) async {
    print("Selected Date in validateTimes: $selectedDate");
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser ;

    if (user == null) {
      showToast("User  not authenticated.");
      return;
    }

    if (title.isEmpty) {
      showToast("Plan title cannot be empty.");
      return;
    }

    bool isDuplicate = await _checkForDuplicateTitle(title);
    if (isDuplicate) {
      showToast("Plan title already exists. Please choose a different title.");
      return;
    }

    bool isDuplicateCalendar = await _checkForDuplicateTitleCalendar(title);
    if (isDuplicateCalendar) {
      showToast("Calendar plan title already exists. Please choose a different title.");
      return;
    }

    // Save the latest selected time based on which button was last pressed
    if (isStartSelected) {
      startTime =
      '${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')} $selectedPeriod';
    } else {
      endTime =
      '${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')} $selectedPeriod';
    }
    // Parse start and end times
    DateTime startDateTime = _parseTime(startTime, date: selectedDate);
    DateTime endDateTime = _parseTime(endTime, date: selectedDate);

    // Adjust endDateTime if it is before startDateTime
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

    if (duration.inMinutes < 30) {
      showToast("Minimum duration of sleep is 30 minutes.");
      return;
    }

    if (duration.inHours > 9 ||
        (duration.inHours == 9 && duration.inMinutes.remainder(60) > 0)) {
      showToast("Maximum duration of sleep is 9 hours.");
      return;
    }

    DateTime startNotificationTime = startDateTime.subtract(Duration(minutes: 5)); // 5 minutes before start time
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

    // Create the success message
    showToast('Success! "$title", Your sleep duration is valid.');

    await _addCalendarToFirestore(title, startTime, endTime, selectedDate);

    Navigator.pushReplacement(
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
      hourController.jumpToItem((selectedHour) + 5999); // Update the hour controller
      minuteController.jumpToItem(selectedMinute + 6000); // Update the minute controller
      periodController.jumpToItem(periods.indexOf(selectedPeriod)); // Update the period controller
    } else {
      // Reset to the last selected end time
      List<String> endParts = endTime.split(':');
      selectedHour = int.parse(endParts[0]);
      selectedMinute = int.parse(endParts[1].split(' ')[0]);
      selectedPeriod = endParts[1].split(' ')[1];
      hourController.jumpToItem((selectedHour) + 5999); // Update the hour controller
      minuteController.jumpToItem(selectedMinute + 6000); // Update the minute controller
      periodController.jumpToItem(periods.indexOf(selectedPeriod)); // Update the period controller
    }
  }

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
    return DateTime(date.year, date.month, date.day, hour, minute);
  }
}