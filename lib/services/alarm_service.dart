import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

class AlarmService {
  // Schedule a one-shot alarm at a specific time
  Future<void> scheduleAlarm({
    required int id,
    required DateTime triggerTime,
    required Function callback,
  }) async {
    print("Scheduling alarm with ID: $id at $triggerTime");

    await AndroidAlarmManager.oneShotAt(
      triggerTime,
      id, // Unique ID for the alarm
      callback, // Function to execute when alarm triggers
      exact: true, // Ensures precise timing
      wakeup: true, // Wakes up the device if asleep
    );
  }

  // Cancel a specific alarm
  Future<void> cancelAlarm(int id) async {
    print("Canceling alarm with ID: $id");
    await AndroidAlarmManager.cancel(id);
  }
}
