import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Request permission to show notifications (Android 13+)
  Future<void> requestNotificationPermission() async {
    var status = await Permission.notification.status;
    if (!status.isGranted) {
      await Permission.notification.request();
    }
  }

  // Schedule a notification for a specific time
  Future<void> scheduleNotification(
      int id, String title, DateTime startTime) async {
    final scheduledTime =
        tz.TZDateTime.from(startTime.subtract(Duration(minutes: 5)), tz.local);

    print(
        "Scheduled notification for '$title' at $scheduledTime"); // Check the calculated time

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id', // Channel ID
      'Your Channel Name',
      channelDescription: 'Your Channel Description',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id, // Unique ID
        'Plan Reminder',
        "Your '$title' plan is about to start!",
        scheduledTime,
        platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
      print("Notification scheduled successfully for '$title'");
    } catch (e) {
      print('Error scheduling notification: $e');
    }
  }
}
