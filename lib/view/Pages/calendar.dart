import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:sleepful/view/Pages/Plans/update_plans.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double titleFontSize = screenWidth * 0.06;
    double subtitleFontSize = screenWidth * 0.04;
    DateTime today = DateTime.now();

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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child:Column(
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
                      headerStyle:
                      HeaderStyle(
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
                      selectedDayPredicate: (day) => isSameDay(day, today),
                      focusedDay: today,
                      firstDay: DateTime.utc(2022,01,01),
                      lastDay: DateTime.utc(2026,12,31),
                      daysOfWeekStyle:DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                            color: Color(0xFFAB9FD1),
                            fontSize: subtitleFontSize,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'
                        ),

                        weekendStyle: TextStyle(
                            color:Color(0xFFAB9FD1),
                            fontSize: subtitleFontSize,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'
                        ),
                      ),
                      calendarStyle: CalendarStyle(
                        defaultTextStyle:
                        TextStyle(
                            color: Color(0xFFB4A9D6),
                            fontSize: subtitleFontSize,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'
                        ),
                        selectedDecoration: BoxDecoration(
                          color:Color(0xFFB4A9D6),
                          shape: BoxShape.circle,
                        ),
                        weekendTextStyle:TextStyle(
                            color: Color(0xFFB4A9D6),
                            fontSize: subtitleFontSize,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'
                        ),
                      ),
                  ),
              ),
          ),
          const SizedBox(height: 20),
          _buildPlanCard(context, 'Today Schedule', '2:00 AM - 11:00 AM'),
        ],
        )
      ),
      );
      // Center(
      //   child: Text('Calendar',
      //     style: TextStyle(
      //       color: Colors.white,
      //
            // Set the text color to white
  }
}

Widget _buildPlanCard(BuildContext context, String title, String timePeriod) {
  return Card(
    color: Color(0xFF1F1249),
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      // Padding for the entire card
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align to the left
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            timePeriod,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          ),
          const SizedBox(height: 8.0),
          // Add some space before the days section
          // Days of the Week Section
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF6149A7),
              borderRadius:
              BorderRadius.circular(20.0), // Adjust the radius as needed
            ),
            padding: const EdgeInsets.all(8.0),
          ),
          // Update and Delete Section
          Container(
            color: Color(0xFF1F1249),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    // Navigate to Update Plan page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdatePlans(
                            title: title,
                          )), // Replace with your UpdatePlanPage widget
                    );
                  },
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
                Container(
                  width: 1, // Width of the line
                  height: 24, // Height of the line
                  color: Colors.white, // Color of the line
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
