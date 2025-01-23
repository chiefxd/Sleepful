import 'dart:isolate';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';

@pragma('vm:entry-point')
void startCallback() {
  // The setTaskHandler function must be called to handle the task in the background.
  FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}

class MyTaskHandler extends TaskHandler {
  SendPort? _sendPort;
  int _eventCount = 0;

  @override
  Future<void> onStart(DateTime timestamp, SendPort? sendPort) async {
    _sendPort = sendPort;

    // You can use the getData function to get the stored data.
    final customData =
        await FlutterForegroundTask.getData<String>(key: 'customData');
    print('✅ customData: $customData');
  }

  @override
  Future<void> onEvent(DateTime timestamp, SendPort? sendPort) async {
    // Send data to the main isolate.
    FlutterForegroundTask.updateService(
      notificationTitle: 'Sleepful is active',
      notificationText: 'Updated at ${timestamp.toString()}',
    );

    _sendPort?.send(timestamp);
    _eventCount++;
    print('✅ EventCount: $_eventCount');

    // Example: Show a notification after 5 events
    // if (_eventCount >= 5) {
    //   // Access NotificationService instance and show notification
    //   NotificationService().showNotification(
    //     'Sleepful Foreground Task',
    //     'Event count reached 5!',
    //   );
    //   _eventCount = 0; // Reset counter
    // }
  }

  @override
  Future<void> onDestroy(DateTime timestamp, SendPort? sendPort) async {
    // You can use the clearAllData function to clear all the stored data.
    await FlutterForegroundTask.clearAllData();
  }

  @override
  void onButtonPressed(String id) {
    // Called when the notification button on the Android platform is pressed.
    print('✅ onButtonPressed >> $id');
    _sendPort?.send('onNotificationButtonPressed');
  }

  @override
  void onNotificationPressed() {
    // Called when the notification itself on the Android platform is pressed.
    //
    // "android.permission.SYSTEM_ALERT_WINDOW" permission must be granted for
    // this function to be called.

    // Note that the app will only route to "/resume-route" when it is exited so
    // it is not guaranteed to reach that route.
    FlutterForegroundTask.launchApp(); // Changed to just launch the app
    _sendPort?.send('onNotificationPressed');
  }

  @override
  Future<void> onRepeatEvent(DateTime timestamp, SendPort? sendPort) async {
    // Send data to the main isolate.
    FlutterForegroundTask.updateService(
      notificationTitle: 'Sleepful is active',
      notificationText: 'Updated at ${timestamp.toString()}',
    );

    _sendPort?.send(timestamp);
    _eventCount++;
    print('✅ EventCount: $_eventCount');

    // Example: Show a notification after 5 events
    // if (_eventCount >= 5) {
    //   // Access NotificationService instance and show notification
    //   NotificationService().showNotification(
    //     'Sleepful Foreground Task',
    //     'Event count reached 5!',
    //   );
    //   _eventCount = 0; // Reset counter
    // }
  }
}
