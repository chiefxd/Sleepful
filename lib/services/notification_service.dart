import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../main.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  // Initialize the notification plugin and create a notification channel
  Future<void> initialize() async {
    // Initialize time zones
    tz.initializeTimeZones();
    final String timeZoneName = tz.local.name;
    tz.setLocalLocation(tz.getLocation(timeZoneName));
    print('✅ Timezone set to: $timeZoneName');

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    // await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload != null) {
          final data = jsonDecode(response.payload!);
          if (data['action'] == 'view_plans') {
            navigatorKey.currentState?.pushNamed('/viewPlans');
          }
        }
      },
    );
    print('✅ NotificationService initialized.');
  }

  // Request permission to show notifications (Android 13+)
  Future<void> requestNotificationPermission() async {
  //   var status = await Permission.notification.status;
  //   if (!status.isGranted) {
  //     status = await Permission.notification.request();
  //     if (status.isGranted) {
  //       print('Notification permissions granted.');
  //     } else {
  //       print('Notification permissions denied.');
  //     }
  //   } else {
  //     print('Notification permissions already granted.');
  //   }
  // }
    final status = await Permission.notification.status;

    if (status.isGranted) {
      print('✅ Notification permissions already granted.');
    } else {
      print('⚠️ Requesting notification permissions...');
      final result = await Permission.notification.request();

      if (result.isGranted) {
        print('✅ Notification permissions granted.');
      } else if (result.isDenied) {
        print('⚠️ Notification permissions denied.');
      } else if (result.isPermanentlyDenied) {
        print('🚫 Notification permissions permanently denied. Open settings to enable.');
        openAppSettings();
      }
    }
  }

  Future<void> showNotification(String title, String body) async {
    const androidDetails = AndroidNotificationDetails(
      'immediate_channel_id',
      'Immediate Notifications',
      channelDescription: 'Channel for immediate notifications.',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      1, // Notification ID (0 for a generic notification)
      title, // Notification title
      body, // Notification body
      notificationDetails,
      payload: jsonEncode({'action': 'view_plans'}),
    );

    print('🔔 Immediate notification shown: $title');
  }

  // Schedule a notification for a specific time
  Future<void> scheduleNotification(
      int id, String title, DateTime scheduleTime) async {
    final androidDetails = AndroidNotificationDetails(
      'your_channel_id',
      'Your Channel Name',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true, // Ensure the sound is set for the notification
      enableVibration: true, // Enable vibration if needed
      ongoing: true,
      timeoutAfter: 60000,//null
    );

    final notificationDetails = NotificationDetails(android: androidDetails);

    print('Scheduling notification at: $scheduleTime'); // Debugging line

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      'Your scheduled plan is about to start!',
      tz.TZDateTime.from(
          scheduleTime, tz.local), // Ensuring time is converted to TZDateTime
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exact,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    print('Notification scheduled successfully');
  }

  // Method to play an endTime alarm with a custom sound
  Future<void> playCustomAlarm(String title, String body, String soundFile) async {
    final androidDetails = AndroidNotificationDetails(
      'end_time_alarm_channel', // Unique channel ID for end time alarm
      'End Time Alarm',
      channelDescription: 'Alarm for end time with custom sound.',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound(soundFile),
      enableVibration: false, // Disable vibration
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction(
          'navigate_to_view_plans', // Action ID
          'View Plans', // Action button text
        ),
      ],
    );

    final notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      1, // Notification ID (unique for end time alarm)
      title, // Notification title
      body, // Notification body
      notificationDetails,
      payload: jsonEncode({'action': 'view_plans'}), // Add payload
    );

    print('🔔 Custom alarm notification shown with button: $title');
  }

  // Cancel a notification
  Future<void> cancelNotification(int id) async {
    try {
      await flutterLocalNotificationsPlugin.cancel(id);
      print('Notification with id=$id canceled.');
    } catch (e) {
      print('Error canceling notification with id=$id: $e');
    }
  }
}
