import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sleepful/controller/Calendar/test_today_plan_controller.dart'; // Import the SleepPlanController
import 'package:sleepful/view/Pages/Calendar/test_calendar_add.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../Components/plus_button.dart';
import '../../Navbar/bottom_navbar.dart';
// import '../Plans/update_plans.dart';
import '../home_page.dart';
import 'test_calendar_update.dart';

class Calendar extends StatefulWidget {
  final int selectedIndex;
  final String userId;

  const Calendar({super.key, this.selectedIndex = 1, required this.userId});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  final SleepPlanController sleepPlanController = SleepPlanController();
  String? sleepPlan;
  Map<DateTime, List<Map<String, dynamic>>>? sleepPlanList;

  Future<Map<String, dynamic>?> fetchPlanData(String planId) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    DocumentSnapshot calendarSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .collection('Calendar Plans')
        .doc(planId)
        .get();

    if (calendarSnapshot.exists) {
      print("Fetched from Calendar Plans: ${calendarSnapshot.data()}");
      return calendarSnapshot.data() as Map<String, dynamic>;
    }

    DocumentSnapshot plansSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .collection('Plans')
        .doc(planId)
        .get();

    if (plansSnapshot.exists) {
      print("Fetched from Plans: ${plansSnapshot.data()}");
      return plansSnapshot.data() as Map<String, dynamic>;
    }

    return null;
  }

  void _deletePlan(BuildContext context, String planId, String title) async {
    final planData = await fetchPlanData(planId);

    if (planData == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not fetch plan data.')),
      );
      return;
    }

    String collectionToDeleteFrom =
        planData['isCalendar'] == true ? 'Calendar Plans' : 'Plans';

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
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
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
                      onPressed: () async {
                        User? user = FirebaseAuth.instance.currentUser;
                        await FirebaseFirestore.instance
                            .collection('Users')
                            .doc(user?.uid)
                            .collection(collectionToDeleteFrom)
                            .doc(planId)
                            .delete();
                        sleepPlanController
                            .fetchSleepPlans(widget.userId)
                            .listen((sleepPlans) {
                          setState(() {
                            sleepPlanList = sleepPlans;
                          });
                        });

                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Delete',
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

  @override
  void initState() {
    super.initState();
    selectedDay = focusedDay;
    sleepPlanController.fetchSleepPlans(widget.userId).listen((sleepPlans) {
      setState(() {
        sleepPlanList = sleepPlans;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
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
            'Calendar',
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          child: TableCalendar(
                            locale: "en_US",
                            rowHeight: 50,
                            availableGestures: AvailableGestures.all,
                            selectedDayPredicate: (day) =>
                                isSameDay(selectedDay, day),
                            focusedDay: focusedDay,
                            firstDay: DateTime.utc(2022, 01, 01),
                            lastDay: DateTime.utc(2026, 12, 31),
                            onDaySelected: (selectedDay, focusedDay) {
                              setState(() {
                                this.selectedDay = selectedDay;
                                this.focusedDay = selectedDay;
                              });
                              print("Selected Day: $selectedDay");
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: sleepPlanController
                                      .getSleepPlans(selectedDay!)
                                      .first ==
                                  "No sleep plan for this date"
                              ? [
                                  Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      border: Border.all(
                                        color: const Color(0xFFB4A9D6),
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      "There's no plans for this date.",
                                    ),
                                  ),
                                ]
                              : sleepPlanController
                                  .getSleepPlans(selectedDay!)
                                  .map((plan) {
                                  final parts = plan.split(': ');
                                  if (parts.length < 2) {
                                    return SizedBox();
                                  }

                                  final title = parts[0];
                                  final timeDetails = parts[1].split(' to ');
                                  if (timeDetails.length < 2) {
                                    return SizedBox();
                                  }

                                  final startTimeString = timeDetails[0]
                                      .replaceFirst('Sleep from ', '');
                                  final endTimeString = timeDetails[1];

                                  DateTime startTime =
                                      DateTime.parse(startTimeString);
                                  DateTime endTime =
                                      DateTime.parse(endTimeString);

                                  String formattedStartTime =
                                      DateFormat.jm('en_US').format(startTime);
                                  String formattedEndTime =
                                      DateFormat.jm('en_US').format(endTime);

                                  DateTime normalizedDate = DateTime(
                                      selectedDay!.year,
                                      selectedDay!.month,
                                      selectedDay!.day);
                                  final planDetails =
                                      sleepPlanList?[normalizedDate]
                                          ?.firstWhere(
                                              (plan) => plan['title'] == title,
                                              orElse: () => {
                                                    'planId': 'Unknown Plan ID',
                                                    'selectedDays': [],
                                                  });
                                  final selectedDays =
                                      (planDetails?['selectedDays']
                                                  as List<String>?)
                                              ?.join(', ') ??
                                          "No selected days";

                                  final planId = planDetails?['planId'];
                                  String formattedDate =
                                      DateFormat('d MMMM yyyy')
                                          .format(selectedDay!);
                                  String dayString =
                                      DateFormat('EEEE').format(selectedDay!);

                                  if (planDetails?['collection'] ==
                                      'Calendar Plans') {
                                    DateTime selectedDate =
                                        planDetails?['selectedDate'];
                                    if (DateTime(
                                            selectedDate.year,
                                            selectedDate.month,
                                            selectedDate.day) !=
                                        DateTime(
                                            selectedDay!.year,
                                            selectedDay!.month,
                                            selectedDay!.day)) {
                                      return SizedBox(); // Skip this plan if the selectedDate does not match
                                    }
                                  }

                                  return Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xFF26184A),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                title,
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                'Day: $dayString, Date: $formattedDate',
                                              ),
                                              Text(
                                                'Time: $formattedStartTime - $formattedEndTime',
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            print("Clicked on plan: $title");

                                            final planDetails = sleepPlanList?[
                                                    normalizedDate]
                                                ?.firstWhere(
                                                    (plan) =>
                                                        plan['title'] == title,
                                                    orElse: () => {
                                                          'planId':
                                                              'Unknown Plan ID',
                                                          'selectedDays': [],
                                                        });

                                            final planId =
                                                planDetails?['planId'] ??
                                                    'Unknown Plan ID';
                                            print("Plan ID: $planId");

                                            final planData =
                                                await fetchPlanData(planId);
                                            if (planData != null) {
                                              final startTime =
                                                  planData['startTime'];
                                              final endTime =
                                                  planData['endTime'];
                                              final isCalendar =
                                                  planData['isCalendar'];
                                              print(
                                                  "Navigating to update page. isCalendar: $isCalendar");

                                              if (isCalendar == true) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateCalendar(
                                                      title: title,
                                                      planId: planId,
                                                      startTime: startTime,
                                                      endTime: endTime,
                                                      selectedDays: selectedDays
                                                          .split(', '),
                                                      selectedDate:
                                                          selectedDay!,
                                                      isCalendar: isCalendar,
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateCalendar(
                                                      title: title,
                                                      planId: planId,
                                                      startTime: startTime,
                                                      endTime: endTime,
                                                      selectedDays: selectedDays
                                                          .split(', '),
                                                      selectedDate:
                                                          selectedDay!,
                                                      isCalendar: isCalendar,
                                                    ),
                                                  ),
                                                );
                                              }
                                              // else {
                                              //   Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //       builder: (context) =>
                                              //           UpdatePlans(
                                              //         title: title,
                                              //         planId: planId,
                                              //         startTime: startTime,
                                              //         endTime: endTime,
                                              //         selectedDays: selectedDays
                                              //             .split(', '),
                                              //       ),
                                              //     ),
                                              //   );
                                              // }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        'Could not fetch plan data.')),
                                              );
                                            }
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(5),
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF6149A7),
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                bottom: Radius.circular(10),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      'Update',
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 20,
                                                  width: 1,
                                                  color: Colors.white
                                                      .withOpacity(0.8),
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      _deletePlan(context,
                                                          planId, title);
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        'Delete',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              BottomNavbar(selectedIndex: widget.selectedIndex),
            ],
          ),
          Positioned(
            bottom: 56,
            left: MediaQuery.of(context).size.width / 2 - 27,
            child: PlusButton(
              targetPage: AddCalendar(selectedDate: selectedDay!),
            ),
          )
        ],
      ),
    );
  }
}
