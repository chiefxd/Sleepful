import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../handler/foreground_handler.dart';
import '../main.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();
  ReceivePort? _receivePort;

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

    await _initForegroundTask();
    await requestPermissions();
  }

  Future<void> requestPermissions() async {
    await requestNotificationPermission();
    await requestIgnoreBatteryOptimizations();
  }

  // Request permission to show notifications (Android 13+)
  Future<void> requestNotificationPermission() async {
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
        print(
            '🚫 Notification permissions permanently denied. Open settings to enable.');
        openAppSettings();
      }
    }
  }

  Future<void> requestIgnoreBatteryOptimizations() async {
    if (Platform.isAndroid) {
      try {
        final isIgnoring =
            await Permission.ignoreBatteryOptimizations.isGranted;
        if (!isIgnoring) {
          final status = await Permission.ignoreBatteryOptimizations.request();
          if (status.isGranted) {
            print("✅ Battery optimizations ignored.");
          } else {
            print("⚠️ Battery optimizations NOT ignored.");
            // Optionally, guide the user to settings
            // await openAppSettings();
          }
        } else {
          print("✅ Battery optimizations already ignored.");
        }
      } catch (e) {
        print("Error requesting battery optimization permission: $e");
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
      timeoutAfter: null,
      // Use setExactAndAllowWhileIdle for more precise scheduling (if needed)
      // This requires the USE_FULL_SCREEN_INTENT permission
      styleInformation: BigTextStyleInformation(''),
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
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    print('✅ Notification scheduled successfully.');
    _startForegroundTask();
  }

  // Method to play an endTime alarm with a custom sound
  Future<void> playCustomAlarm(
      String title, String body, String soundFile) async {
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

  // Initialize the foreground service
  Future<void> _initForegroundTask() async {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'foreground_service',
        channelName: 'Foreground Service',
        channelDescription: 'Ongoing background tasks',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
        iconData: const NotificationIconData(
          resType: ResourceType.mipmap,
          resPrefix: ResourcePrefix.ic,
          name: 'launcher', // Make sure this icon exists in your project
        ),
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: const ForegroundTaskOptions(
        interval: 5000, // 5 seconds (adjust as needed)
        autoRunOnBoot: true,
        allowWifiLock: true,
      ),
    );

    _receivePort = FlutterForegroundTask.receivePort;
    _receivePort?.listen((message) {
      if (message is DateTime) {
        print('✅ foreground task received: ${message.toIso8601String()}');
      } else {
        print('✅ foreground task received: $message');
      }

      if (message == 'onNotificationButtonPressed') {
        navigatorKey.currentState?.pushNamed('/viewPlans');
      }
    });

    print('✅ Foreground task initialized.');
  }

  // Start the foreground service
  Future<void> _startForegroundTask() async {
    await FlutterForegroundTask.stopService();

    await FlutterForegroundTask.startService(
      notificationTitle: 'Sleepful is running',
      notificationText: 'Tap to return to the app',
      callback: startCallback,
    );
  }

  Future<void> _stopForegroundTask() async {
    await FlutterForegroundTask.stopService();
  }
}
