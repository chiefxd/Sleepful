import 'package:flutter/material.dart';
import 'package:sleepful/controller/Calendar/today_plan_controller.dart'; // Import the SleepPlanController
import 'package:table_calendar/table_calendar.dart';

import '../../Components/plus_button.dart';
import '../../Navbar/bottom_navbar.dart';
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

  @override
  void initState() {
    super.initState();
    selectedDay = focusedDay; // Initialize selectedDay to today
    sleepPlanController.fetchSleepPlans(widget.userId).listen((_) {
      setState(() {
        sleepPlan = sleepPlanController.getSleepPlans(selectedDay!).join('\n');
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
                                color: Color(0xFFB4A9D6),
                                fontSize: subtitleFontSize,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        // Add some space below the calendar
                        // The plans will be displayed here
                        // Column(
                        //   children: sleepPlanController.getSleepPlans(selectedDay!).first == "No sleep plan for this date"
                        //       ? [
                        //   Container(
                        //     margin: const EdgeInsets.symmetric(vertical: 5),
                        //     padding: const EdgeInsets.all(10),
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10),
                        //       color: Theme.of(context).colorScheme.surface,
                        //       border: Border.all(
                        //         color: const Color(0xFFB4A9D6),
                        //         width: 1,
                        //       ),
                        //     ),
                        //     child: Text(
                        //       "There's no plans for this date.",
                        //       style: TextStyle(
                        //         color: Theme.of(context).colorScheme.primary,
                        //         fontSize: subtitleFontSize,
                        //         fontWeight: FontWeight.bold,
                        //         fontFamily: 'Montserrat',
                        //       ),
                        //     ),
                        //   ),
                        //     ]
                        //       : sleepPlanController.getSleepPlans(selectedDay!).map((plan) {
                        //     final parts = plan.split(': ');
                        //     if (parts.length < 2) {
                        //       return SizedBox(); // Return empty widget for invalid plan format
                        //     }
                        //
                        //     final title = parts[0];
                        //     final timeDetails = parts[1].split(' to ');
                        //     if (timeDetails.length < 2) {
                        //       return SizedBox(); // Return empty widget for invalid time details
                        //     }
                        //
                        //     final startTime = timeDetails[0].replaceFirst('Sleep from ', '');
                        //     final endTime = timeDetails[1];
                        //
                        //     return Container(
                        //       margin: const EdgeInsets.symmetric(vertical: 5),
                        //       padding: const EdgeInsets.all(10),
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(10),
                        //         color: Theme.of(context).colorScheme.surface,
                        //         border: Border.all(color: const Color(0xFFB4A9D6), width: 1),
                        //       ),
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Text(
                        //             title,
                        //             style: TextStyle(
                        //               color: Theme.of(context).colorScheme.primary,
                        //               fontSize: subtitleFontSize,
                        //               fontWeight: FontWeight.bold,
                        //               fontFamily: 'Montserrat',
                        //             ),
                        //           ),
                        //           const SizedBox(height: 5),
                        //           Text(
                        //             'Start Time: $startTime',
                        //             style: TextStyle(
                        //               color: Theme.of(context).colorScheme.primary,
                        //               fontSize: subtitleFontSize,
                        //               fontFamily: 'Montserrat',
                        //             ),
                        //           ),
                        //           Text(
                        //             'End Time: $endTime',
                        //             style: TextStyle(
                        //               color: Theme.of(context).colorScheme.primary,
                        //               fontSize: subtitleFontSize,
                        //               fontFamily: 'Montserrat',
                        //             ),
                        //           ),
                        //           const SizedBox(height: 5),
                        //           Row(
                        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Text(
                        //                 'Update',
                        //                 style: TextStyle(
                        //                   color: Theme.of(context).colorScheme.primary,
                        //                   fontSize: subtitleFontSize,
                        //                   fontFamily: 'Montserrat',
                        //                 ),
                        //               ),
                        //               Text(
                        //                 '${selectedDay!.toLocal()}'.split(' ')[0], // Display the selected date
                        //                 style: TextStyle(
                        //                   color: Theme.of(context).colorScheme.primary,
                        //                   fontSize: subtitleFontSize,
                        //                   fontFamily: 'Montserrat',
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ],
                        //       ),
                        //     );
                        //   }).toList(),
                        // ),
                        Column(
                          children: sleepPlanController.getSleepPlans(selectedDay!).first == "No sleep plan for this date"
                              ? [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).colorScheme.surface,
                                border: Border.all(
                                  color: const Color(0xFFB4A9D6),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                "There's no plans for this date.",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: subtitleFontSize,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ),
                          ]
                              : sleepPlanController.getSleepPlans(selectedDay!).map((plan) {
                            final parts = plan.split(': ');
                            if (parts.length < 2) {
                              return SizedBox(); // Return empty widget for invalid plan format
                            }

                            final title = parts[0];
                            final timeDetails = parts[1].split(' to ');
                            if (timeDetails.length < 2) {
                              return SizedBox(); // Return empty widget for invalid time details
                            }

                            final startTime = timeDetails[0].replaceFirst('Sleep from ', '');
                            final endTime = timeDetails[1];

                            // Assuming the plan string contains planId and selectedDays
                            // Assuming the plan string contains planId and selectedDays
                            final additionalInfo = parts[2].split(', '); // Assuming additional info is in the third part
                            final planId = additionalInfo[0].split(': ')[1]; // Extract planId
                            final selectedDaysString = additionalInfo[1].split(': ')[1]; // Extract selectedDays
                            final selectedDays = selectedDaysString.replaceAll(RegExp(r'[\[\]]'), '').split(',').map((e) => e.trim() == 'true').toList(); // Convert to List<bool>

// Convert List<bool> to List<String>
                            final selectedDaysStringList = selectedDays.map((day) => day.toString()).toList(); // Convert to List<String>

                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).colorScheme.surface,
                                border: Border.all(color: const Color(0xFFB4A9D6), width: 1),
                              ),
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
                                    'Start Time: $startTime',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontSize: subtitleFontSize,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                  Text(
                                    'End Time: $endTime',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontSize: subtitleFontSize,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          // Navigate to the time picker page
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => UpdateCalendar(
                                                title: title,
                                                startTime: startTime,
                                                endTime: endTime,
                                                planId: planId, // Now we have planId
                                                selectedDays: selectedDaysStringList, // Pass the converted List<String>
                                              ),
                                            ),
                                          );

                                          // After returning, refresh the sleep plans
                                          sleepPlanController.fetchSleepPlans(widget.userId).listen((_) {
                                            setState(() {
                                              sleepPlan = sleepPlanController.getSleepPlans(selectedDay!).join('\n');
                                            });
                                          });
                                        },
                                        child: Text(
                                          'Update',
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.primary,
                                            fontSize: subtitleFontSize,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${selectedDay!.toLocal()}'.split(' ')[0], // Display the selected date
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.primary,
                                          fontSize: subtitleFontSize,
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                    ],
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
            bottom: 56, // Adjust this value to position the PlusButton
            left: MediaQuery.of(context).size.width / 2 - 27,
            child: const PlusButton(), // Add PlusButton here
          ),
        ],
      ),
    );
  }
}
