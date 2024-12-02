import 'package:flutter/material.dart';
import '../Navbar/bottom_navbar.dart';
import '../Components/plus_button.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:sleepful/controller/Calendar/today_plan_controller.dart'; // Import the SleepPlanController

class Calendar extends StatefulWidget {
  final int selectedIndex;

  const Calendar({super.key, this.selectedIndex = 1});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime today = DateTime.now();
  DateTime? selectedDay; // State variable to keep track of the selected day
  final SleepPlanController sleepPlanController =
      SleepPlanController(); // Instantiate the controller
  String? sleepPlan; // Variable to hold the sleep plan for the selected day

  @override
  void initState() {
    super.initState();
    selectedDay = today; // Initialize selectedDay to today
    sleepPlan = sleepPlanController
        .getSleepPlan(selectedDay!); // Get sleep plan for today
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay; // Update the selected day
      today = selectedDay;
      sleepPlan = sleepPlanController
          .getSleepPlan(selectedDay); // Get sleep plan for the selected day
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
            Navigator.pop(context);
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
              color: Color(0xFFB4A9D6),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF1F1249),
                    ),
                    child: TableCalendar(
                      locale: "en_US",
                      rowHeight: 60,
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                        formatButtonVisible: false,
                        leftChevronIcon: Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xFFB4A9D6),
                        ),
                        rightChevronIcon: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFFB4A9D6),
                        ),
                        titleTextStyle: TextStyle(
                          color: Color(0xFFB4A9D6),
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      availableGestures: AvailableGestures.all,
                      selectedDayPredicate: (day) =>
                          isSameDay(day, selectedDay),
                      focusedDay: today,
                      firstDay: DateTime.utc(2022, 01, 01),
                      lastDay: DateTime.utc(2026, 12, 31),
                      onDaySelected: onDaySelected,
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          color: Color(0xFFAB9FD1),
                          fontSize: subtitleFontSize,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                        weekendStyle: TextStyle(
                          color: Color(0xFFAB9FD1),
                          fontSize: subtitleFontSize,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      calendarStyle: CalendarStyle(
                        defaultTextStyle: TextStyle(
                          color: Color(0xFFB4A9D6),
                          fontSize: subtitleFontSize,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Color(0xFFB4A9D6),
                          shape: BoxShape.circle,
                        ),
                        selectedTextStyle: TextStyle(
                          color: Color(0xFF412E80),
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
                          color: Color(0xFFB4A9D6).withOpacity(0.4),
                          fontSize: subtitleFontSize,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10), // Add margin for spacing
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF1F1249),
                    border: Border.all(color: Color(0xFFB4A9D6), width: 1),
                  ),
                  child: Text(
                    sleepPlan ?? "No sleep plan for this date.",
                    style: TextStyle(
                      color: Color(0xFFB4A9D6),
                      fontSize: subtitleFontSize,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0, // Position at the bottom of the screen
            left: 0,
            right: 0,
            child: BottomNavbar(selectedIndex: widget.selectedIndex),
          ),
          Positioned(
            bottom: 56, // Adjust this value to overlap the BottomNavbar
            left: MediaQuery.of(context).size.width / 2 - 27,
            child: const PlusButton(),
          ),
        ],
      ),
    );
  }
}