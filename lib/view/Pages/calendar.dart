import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class Calendar extends StatelessWidget {
  const Calendar({super.key});

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
                  )
          )
          )
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