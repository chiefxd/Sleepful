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

  Future<String> _addPlanToFirestore(String title, String startTime,
      String endTime, List<String> selectedDays) async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Reference to the Firestore collection
      CollectionReference plansCollection = FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection('Plans');

      DocumentReference docRef = await plansCollection.add({
        'title': title,
        'startTime': startTime,
        'endTime': endTime,
        'selectedDays': selectedDays,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return docRef.id;
    }
    throw Exception("User not authenticated.");
  }

  Future<bool> _checkForDuplicateTitle(String title) async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

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

  Future<void> validateTimes(BuildContext context, String title) async {
    if (title.isEmpty) {
      showToast("Plan title cannot be empty.");
      return;
    }

    bool isDuplicate = await _checkForDuplicateTitle(title);
    if (isDuplicate) {
      showToast("Plan title already exists. Please choose a different title.");
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
    DateTime today = DateTime.now();
    DateTime createdAt = DateTime.now();
    // Parse start and end times
    DateTime startDateTime = _parseTime(startTime, date: today);
    DateTime endDateTime = _parseTime(endTime, date: today);

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

    if (duration.inMinutes < 2) {
      showToast("Minimum duration of sleep is 30 minutes.");
      return;
    }

    if (duration.inHours > 9 ||
        (duration.inHours == 9 && duration.inMinutes.remainder(60) > 0)) {
      showToast("Maximum duration of sleep is 9 hours.");
      return;
    }

    // DateTime currentDate = DateTime.now();
    // int todayIndex = currentDate.weekday % 7;
    // int todayIndex = today.weekday % 7;

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

    // for (int i = 0; i < selectedDays.length; i++) {
    //   if (selectedDays[i]) {
    //     selectedDayLetters.add(fullDayNames[i]);
    //
    //     // Check if today matches the selected day
    //     if (i == todayIndex) {
    //       // Schedule notification for today
    //       DateTime startNotificationTime = DateTime(
    //         currentDate.year,
    //         currentDate.month,
    //         currentDate.day,
    //         startDateTime.hour,
    //         startDateTime.minute,
    //       ).subtract(Duration(minutes: 5)); // 5 minutes before start time
    //
    //       if (startNotificationTime.isAfter(currentDate)) {
    //         final notificationService = NotificationService();
    //         print(
    //             'Scheduling notification for time: $startNotificationTime'); // Debugging line
    //         await notificationService.scheduleNotification(
    //           title.hashCode ^ i, // Unique ID for each day
    //           title,
    //           startNotificationTime,
    //         );
    //       }
    //
    //       DateTime alarmTime = DateTime(
    //         currentDate.year,
    //         currentDate.month,
    //         currentDate.day,
    //         endDateTime.hour,
    //         endDateTime.minute,
    //       );
    //
    //       if (alarmTime.isAfter(currentDate)) {
    //         await alarmService.scheduleAlarm(
    //           id: i + 1000, // Unique ID for alarm
    //           triggerTime: alarmTime,
    //           callback: alarmCallback,
    //         );
    //       }
    //     }
    //   }
    // }
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

        // Only schedule the alarm if the plan is visible today
    //     if (startNotificationTime.isAfter(today) || startNotificationTime.isAtSameMomentAs(today)) {
    //       // Plan is not yet visible today, skip scheduling
    //       continue;
    //     }
    //
    //     // Add the plan to the visible plans list
    //     visiblePlans.add({
    //       'title': title,
    //       'startTime': startDateTime,
    //       'endTime': endDateTime,
    //       'dayIndex': i,
    //     });
    //   }
    // }
        if (i == today.weekday % 7) {
          // If today is the selected day
          if (createdAt.isBefore(startNotificationTime)) {
            // Schedule alarm for today
            // print('Scheduling alarm for today at $startNotificationTime');
            // await alarmService.scheduleAlarm(
            //   id: i + 1000, // Unique ID for alarm
            //   triggerTime: startNotificationTime,
            //   callback: alarmCallback,
            // );
            final notificationService = NotificationService();
                    print(
                        'Scheduling notification for time: $startNotificationTime'); // Debugging line
                    await notificationService.scheduleNotification(
                      title.hashCode ^ i, // Unique ID for each day
                      title,
                      startNotificationTime,
                    );
            DateTime endAlarmTime = endDateTime.subtract(Duration(seconds: 5)); // 5 seconds before end time
            if (today.isAtSameMomentAs(endDateTime) || today.isAfter(endAlarmTime)) {
              print('Triggering alarm callback for end time at $endAlarmTime');
                      await alarmService.scheduleAlarm(
                        id: i + 1000, // Unique ID for alarm
                        triggerTime: endAlarmTime,
                        callback: alarmCallback,
                      );
            }
          }
          // DateTime endAlarmTime = endDateTime.subtract(Duration(seconds: 5));
          // if (today.isAtSameMomentAs(endDateTime) || today.isAfter(endAlarmTime)) {
          //   // Schedule alarm for end time
          //   print('Scheduling alarm for end time at $endAlarmTime');
          //   await alarmService.scheduleAlarm(
          //     id: i + 2000, // Unique ID for end time alarm
          //     triggerTime: endAlarmTime,
          //     callback: alarmCallback,
          //   );
          // }

          // else {
          //   // Schedule for the next occurrence of the selected day
          //   DateTime nextOccurrence = startDateTime.add(Duration(days: 7));
          //   print('Scheduling alarm for next occurrence at $nextOccurrence');
          //   await alarmService.scheduleAlarm(
          //     id: i + 1000, // Unique ID for alarm
          //     triggerTime: nextOccurrence,
          //     callback: alarmCallback,
          //   );
          // }
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

    // Create the success message
    if (selectedDayLetters.isNotEmpty) {
      showToast(
          'Success! "$title", Your sleep duration is valid. Selected days: ${selectedDayLetters.join(', ')}.');
    } else {
      showToast(
          'Success! "$title", Your sleep duration is valid. No days selected.');
    }

    await _addPlanToFirestore(title, startTime, endTime, selectedDayLetters);

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
