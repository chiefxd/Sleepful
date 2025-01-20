import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sleepful/controller/Calendar/today_plan_controller.dart'; // Import the SleepPlanController
import 'package:sleepful/view/Pages/Calendar/calendar_add.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../Components/plus_button.dart';
import '../../Navbar/bottom_navbar.dart';
import '../Plans/update_plans.dart';
import '../home_page.dart';
import 'calendar_update.dart';

class Calendar extends StatefulWidget {
  final int selectedIndex;
  final String userId;

  const Calendar({super.key, this.selectedIndex = 1, required this.userId});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay; // State variable to keep track of the selected day
  final SleepPlanController sleepPlanController =
  SleepPlanController(); // Instantiate the controller
  String? sleepPlan; // Variable to hold the sleep plan for the selected day
  Map<DateTime, List<Map<String, dynamic>>>? sleepPlanList;

  Future<Map<String, dynamic>?> fetchPlanData(String planId) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    // First, check if the plan exists in Calendar Plans
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

    // If not found in Calendar Plans, check Plans collection
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
    // Fetch the plan data to check the isCalendar field
    final planData = await fetchPlanData(planId);

    if (planData == null) {
      // Handle the case where the plan data could not be fetched
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not fetch plan data.')),
      );
      return;
    }

    // Determine the collection to delete from based on isCalendar
    String collectionToDeleteFrom = planData['isCalendar'] == true ? 'Calendar Plans' : 'Plans';

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
                        User? user = FirebaseAuth.instance.currentUser ;
                        FirebaseFirestore.instance
                            .collection('Users')
                            .doc(user?.uid)
                            .collection(collectionToDeleteFrom) // Use the determined collection
                            .doc(planId)
                            .delete(); // Perform the delete operation
                        Navigator.of(context).pop(); // Close the dialog
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


  @override
  void initState() {
    super.initState();
    selectedDay = focusedDay; // Initialize selectedDay to today
    sleepPlanController.fetchSleepPlans(widget.userId).listen((sleepPlans) {
      setState(() {
        // sleepPlan = sleepPlanController.getSleepPlans(selectedDay!).join('\n');
        sleepPlanList = sleepPlans;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double titleFontSize = screenWidth * 0.06;
    double subtitleFontSize = screenWidth * 0.04;

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
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  // Wrap the body in a SingleChildScrollView
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
                            headerStyle: HeaderStyle(
                              titleCentered: true,
                              formatButtonVisible: false,
                              leftChevronIcon: Icon(
                                Icons.arrow_back_ios,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              rightChevronIcon: Icon(
                                Icons.arrow_forward_ios,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              titleTextStyle: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            availableGestures: AvailableGestures.all,
                            selectedDayPredicate: (day) =>
                                isSameDay(selectedDay, day),
                            focusedDay: focusedDay,
                            firstDay: DateTime.utc(2022, 01, 01),
                            lastDay: DateTime.utc(2026, 12, 31),
                            onDaySelected: (selectedDay, focusedDay) {
                              setState(() {
                                this.selectedDay =
                                    selectedDay; // Update the selected day
                                this.focusedDay = selectedDay;
                              });
                              print("Selected Day: $selectedDay");
                            },
                            daysOfWeekStyle: DaysOfWeekStyle(
                              weekdayStyle: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: subtitleFontSize,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                              weekendStyle: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: subtitleFontSize,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            calendarStyle: CalendarStyle(
                              defaultTextStyle: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: subtitleFontSize,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                              selectedDecoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                              selectedTextStyle: TextStyle(
                                color: Theme.of(context).colorScheme.surface,
                                fontSize: subtitleFontSize,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                              todayDecoration: BoxDecoration(
                                color: Color(0xFF664FAF).withOpacity(0.7),
                                shape: BoxShape.circle,
                              ),
                              todayTextStyle: TextStyle(
                                color: Color(0xFFFFFFFF).withOpacity(0.9),
                                fontSize: subtitleFontSize,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                              weekendTextStyle: TextStyle(
                                color: Color(0xFFB4A9D6),
                                fontSize: subtitleFontSize,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                              outsideTextStyle: TextStyle(
                                color: Color(0xFFB4A9D6).withOpacity(0.6),
                                fontSize: subtitleFontSize,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: sleepPlanController
                              .getSleepPlans(selectedDay!)
                              .first ==
                              "No sleep plan for this date"
                          // children: sleepPlanController.getSleepPlans(selectedDay!).isEmpty
                              ? [
                            // children: sleepPlanController.getSleepPlans(selectedDay!).isEmpty
                            //     ? [
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
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary,
                                  fontSize: subtitleFontSize,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ),
                          ]
                              : sleepPlanController
                              .getSleepPlans(selectedDay!)
                              .map((plan) {
                            // print("Plan: $plan");
                            final parts = plan.split(': ');
                            if (parts.length < 2) {
                              return SizedBox(); // Return empty widget for invalid plan format
                            }

                            final title = parts[0];
                            final timeDetails = parts[1].split(' to ');
                            if (timeDetails.length < 2) {
                              return SizedBox(); // Return empty widget for invalid time details
                            }

                            final startTimeString = timeDetails[0].replaceFirst('Sleep from ', '');
                            final endTimeString = timeDetails[1];

                            // Parse the start and end time strings into DateTime objects
                            DateTime startTime = DateTime.parse(startTimeString);
                            DateTime endTime = DateTime.parse(endTimeString);

                            // Format the DateTime objects into the desired format
                            String formattedStartTime = DateFormat.jm('en_US').format(startTime); // e.g., 10:20 PM
                            String formattedEndTime = DateFormat.jm('en_US').format(endTime); // e.g., 5:00 AM

                            // final title = plan['title'];
                            // final startTime = plan['startTime'];
                            // final endTime = plan['endTime'];
                            // final planId = plan['planId']; // Now this is correctly extracted
                            // final selectedDays = plan['selectedDays']; // Now this is correctly extracted
                            // final planDetails = sleepPlanController
                            //     .sleepPlans[selectedDay!]
                            //     ?.firstWhere(
                            //         (plan) => plan['title'] == title);
                            // final planId = planDetails?['planId'] ??
                            //     "Unknown Plan ID"; // Use actual planId
                            // final selectedDays = (planDetails?[
                            //             'selectedDays'] as List<String>?)
                            //         ?.join(', ') ??
                            //     "No selected days"; // Use actual selectedDays
                            DateTime normalizedDate = DateTime(selectedDay!.year, selectedDay!.month, selectedDay!.day);
                            final planDetails = sleepPlanList?[normalizedDate]
                                ?.firstWhere(
                                    (plan) => plan['title'] == title,
                                orElse: () => {
                                  'planId': 'Unknown Plan ID',
                                  'selectedDays': [],
                                }
                            );
                            final selectedDays = (planDetails?['selectedDays'] as List<String>?)?.join(', ') ?? "No selected days";

                            final planId = planDetails?['planId']; // Now this will never be null
                            // final selectedDays = (planDetails?['selectedDays'] as List<String>?)?.join(', ') ?? "No selected days"; // Use actual selectedDays
                            String formattedDate = DateFormat('d MMMM yyyy').format(selectedDay!);
                            String dayString = DateFormat('EEEE').format(selectedDay!);

                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // color: Theme.of(context).colorScheme.surface,
                                color: Color(0xFF26184A),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10), // Apply padding here
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          title,
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.primary,
                                            fontSize: subtitleFontSize,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'Day: $dayString, Date: $formattedDate',
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.primary,
                                            fontSize: subtitleFontSize,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                        Text(
                                          'Time: $formattedStartTime - $formattedEndTime',
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.primary,
                                            fontSize: subtitleFontSize,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                        // Text(
                                        //   'Plan ID: $planId',
                                        //   style: TextStyle(
                                        //     color: Theme.of(context)
                                        //         .colorScheme
                                        //         .primary,
                                        //     fontSize: subtitleFontSize,
                                        //     fontFamily: 'Montserrat',
                                        //   ),
                                        // ),
                                        // Text(
                                        //   'Selected Days: $selectedDays',
                                        //   style: TextStyle(
                                        //     color: Theme.of(context)
                                        //         .colorScheme
                                        //         .primary,
                                        //     fontSize: subtitleFontSize,
                                        //     fontFamily: 'Montserrat',
                                        //   ),
                                        // ),
                                        // Text(
                                        //   'Start Time: $startTime',
                                        //   style: TextStyle(
                                        //     color: Theme.of(context)
                                        //         .colorScheme
                                        //         .primary,
                                        //     fontSize: subtitleFontSize,
                                        //     fontFamily: 'Montserrat',
                                        //   ),
                                        // ),
                                        // Text(
                                        //   'End Time: $endTime',
                                        //   style: TextStyle(
                                        //     color: Theme.of(context)
                                        //         .colorScheme
                                        //         .primary,
                                        //     fontSize: subtitleFontSize,
                                        //     fontFamily: 'Montserrat',
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      // Log the title of the plan being clicked
                                      print("Clicked on plan: $title");

                                      // Fetch the plan details from the sleepPlanList
                                      final planDetails = sleepPlanList?[normalizedDate]
                                          ?.firstWhere(
                                              (plan) => plan['title'] == title,
                                          orElse: () => {
                                            'planId': 'Unknown Plan ID',
                                            'selectedDays': [],
                                          }
                                      );

                                      // Get the planId from the fetched plan details
                                      final planId = planDetails?['planId'] ?? 'Unknown Plan ID';
                                      print("Plan ID: $planId"); // Debugging line

                                      // Fetch the plan data from Firestore
                                      final planData = await fetchPlanData(planId);
                                      if (planData != null) {
                                        final startTime = planData['startTime'];
                                        final endTime = planData['endTime'];
                                        final isCalendar = planData['isCalendar']; // Check the isCalendar field
                                        print("Navigating to update page. isCalendar: $isCalendar"); // Debugging line

                                        // Navigate to the appropriate page based on isCalendar
                                        if (isCalendar == true) {
                                          // If isCalendar is true, navigate to UpdateCalendar
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => UpdateCalendar(
                                                title: title,
                                                planId: planId,
                                                startTime: startTime, // Pass the fetched startTime
                                                endTime: endTime, // Pass the fetched endTime
                                                selectedDays: selectedDays.split(', '),
                                              ),
                                            ),
                                          );
                                        } else {
                                          // If isCalendar is false, navigate to UpdatePlans
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => UpdatePlans(
                                                title: title,
                                                planId: planId,
                                                startTime: startTime, // Pass the fetched startTime
                                                endTime: endTime, // Pass the fetched endTime
                                                selectedDays: selectedDays.split(', '),
                                              ),
                                            ),
                                          );
                                        }
                                      } else {
                                        // Handle the case where the plan data could not be fetched
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Could not fetch plan data.')),
                                        );
                                      }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF6149A7),
                                        borderRadius: BorderRadius.vertical(
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
                                                style: TextStyle(
                                                  color: Colors.white.withOpacity(0.8),
                                                  fontSize: subtitleFontSize,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Montserrat',
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 20,
                                            width: 1,
                                            color: Colors.white.withOpacity(0.8),
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                _deletePlan(context, planId, title); // Call the delete function
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                    color: Color(0xFFFF474C).withOpacity(0.8),
                                                    fontSize: subtitleFontSize,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Montserrat',
                                                  ),
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
            child: const PlusButton(targetPage: AddCalendar(),),
          ),
        ],
      ),
    );
  }
}
