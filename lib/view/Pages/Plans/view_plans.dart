import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sleepful/services/notification_service.dart';
import 'package:sleepful/view/Pages/Plans/add_plans.dart';
import 'package:sleepful/view/Pages/Plans/update_plans.dart';
import 'package:sleepful/view/Pages/home_page.dart';

import '../../Components/plus_button.dart';
import '../../Navbar/bottom_navbar.dart';

const List<String> daysOfWeek = [
  'Sunday',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday'
];

const dayMapping = {
  'Sunday': 'S',
  'Monday': 'M',
  'Tuesday': 'T',
  'Wednesday': 'W',
  'Thursday': 'T',
  'Friday': 'F',
  'Saturday': 'S',
};

class ViewPlans extends StatelessWidget {
  const ViewPlans({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder: (context, innerIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        'assets/images/buttonBack.png',
                        width: 48,
                        height: 48,
                      ),
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Text(
                      'My Plans',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Theme.of(context)
                            .colorScheme
                            .primary,
                      ),
                    ),
                  ),
                  centerTitle: false,
                  floating: false,
                  snap: false,
                  pinned: false,
                  forceElevated: innerIsScrolled,
                ),
              ];
            },
            body: Column(
              children: [
                // List of Plans
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .doc(user?.uid)
                        .collection('Plans')
                        .orderBy('createdAt', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text(
                            'No Plans Found',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 16),
                          ),
                        );
                      }

                      final plans = snapshot.data!.docs;

                      final notificationService = NotificationService();

                      final Set<int> scheduledNotifications = {};

                      for (var i = 0; i < plans.length; i++) {
                        final plan = plans[i];
                        final title = plan['title'];
                        final startTime = plan['startTime'];
                        final selectedDays = List<String>.from(plan['selectedDays'] ?? []);
                        final parsedStartTime = _parseTime(startTime);
                        final notificationTime =
                            parsedStartTime.subtract(Duration(minutes: 5));

                        final todayName = daysOfWeek[DateTime.now().weekday - 1];

                        if (notificationTime.isAfter(DateTime.now()) &&
                            !scheduledNotifications.contains(i) &&
                            selectedDays.contains(todayName)) {
                          try {
                            notificationService.scheduleNotification(
                                i, title, notificationTime);
                            scheduledNotifications.add(i);
                            print(
                                'Scheduled notification for $title at $notificationTime');
                          } catch (e) {
                            print(
                                'Error scheduling notification for $title: $e');
                          }
                        }
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: plans.length,
                        itemBuilder: (context, index) {
                          final plan = plans[index];
                          final title = plan['title'];
                          final startTime = plan['startTime'];
                          final endTime = plan['endTime'];
                          final selectedDays =
                              List<String>.from(plan['selectedDays'] ?? []);

                          return _buildPlanCard(
                            context,
                            plan.id,
                            title,
                            startTime,
                            endTime,
                            selectedDays,
                          );
                        },
                      );
                    },
                  ),
                ),
                BottomNavbar(selectedIndex: -1),
              ],
            ),
          ),
          Positioned(
            bottom: 56,
            left: MediaQuery.of(context).size.width / 2 - 27,
            child: const PlusButton(targetPage: AddPlans(),),
          ),
        ],
      ),
    );
  }

  DateTime _parseTime(dynamic time) {
    try {
      if (time is Timestamp) {
        return time.toDate().toLocal(); // Handle Firestore Timestamp
      } else if (time is String) {
        final DateFormat format = DateFormat.jm(); // Example: "08:42 PM"
        DateTime parsedTime = format.parse(time);
        DateTime now = DateTime.now();
        return DateTime(
            now.year, now.month, now.day, parsedTime.hour, parsedTime.minute);
      } else {
        throw FormatException('Invalid time format: $time');
      }
    } catch (e) {
      print('Error parsing time: $time. Error: $e');
      return DateTime.now();
    }
  }

  Widget _buildPlanCard(BuildContext context, String planId, String title,
      String startTime, String endTime, List<String> selectedDays) {
    return Card(
      color: const Color(0xFF1F1249),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFFE4DCFF),
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              '$startTime - $endTime',
              style: const TextStyle(
                color: Color(0xFFE4DCFF),
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            const SizedBox(height: 8.0),
            // Days of the Week Section
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF6149A7),
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: daysOfWeek.map((day) {
                  // Check if the day is selected
                  bool isSelected = selectedDays.contains(day);
                  return _DayCircle(
                    letter: dayMapping[day]!, // Get the letter
                    isSelected: isSelected,
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdatePlans(
                                title: title,
                                planId: planId,
                                startTime: startTime,
                                endTime: endTime,
                                selectedDays: selectedDays,
                              )),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0),
                    child: const Text(
                      'Update Plan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                  child: const VerticalDivider(
                    color: Colors.white,
                    thickness: 2,
                    width: 20,
                  ),
                ),
                InkWell(
                  onTap: () {
                    _deletePlan(context, planId, title);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0),
                    child: const Text(
                      'Delete Plan',
                      style: TextStyle(
                        color: Color(0xFFFF474C),
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }

  void _deletePlan(BuildContext context, String planId, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.primary,
                    size: 30,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Are you sure you want to delete "$title"?',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(
                        color: const Color(0xFFB4A9D6),
                        width: 2.0,
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const VerticalDivider(color: Colors.white),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: TextButton(
                      onPressed: () {
                        User? user = FirebaseAuth.instance.currentUser;
                        FirebaseFirestore.instance
                            .collection('Users')
                            .doc(user?.uid)
                            .collection('Plans')
                            .doc(planId)
                            .delete();
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _DayCircle extends StatelessWidget {
  final String letter;
  final bool isSelected;

  const _DayCircle({required this.letter, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? Color(0xFFE4DCFF) : Colors.transparent,
        border: Border.all(
          color: isSelected ? Color(0xFFE4DCFF) : Colors.white,
          // Change border color
          width: 2.0,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        letter,
        style: TextStyle(
          color: isSelected ? Colors.black : Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
