import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sleepful/view/Pages/Plans/add_plans.dart';

import '../../Components/plus_button.dart';
import '../../Navbar/bottom_navbar.dart';
import '../home_page.dart';

class SleepingStats extends StatefulWidget {
  final int selectedIndex; // Add selectedIndex parameter

  const SleepingStats({super.key, this.selectedIndex = 3});

  @override
  State<SleepingStats> createState() => _SleepingStatsState();
}

class _SleepingStatsState extends State<SleepingStats> {
// Function to fetch sleep data for the selected week
  Future<List<double>> _fetchSleepDataForWeek(
      DateTime startOfWeek, DateTime endOfWeek) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      return List.filled(7, 0.0);
    }

    final snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Successful Plans')
        .where('successfulDate', isGreaterThanOrEqualTo: startOfWeek)
        .where('successfulDate', isLessThanOrEqualTo: endOfWeek)
        .get();

    final sleepData = List.filled(7, 0.0);

    for (var doc in snapshot.docs) {
      final data = doc.data();
      final successfulDate = (data['successfulDate'] as Timestamp).toDate();
      final startTime = data['startTime'] as String;
      final endTime = data['endTime'] as String;

      final dayIndex = (successfulDate.weekday - 1) % 7;

      final startDateTime = _parseTime(successfulDate, startTime);
      final endDateTime = _parseTime(successfulDate, endTime);
      final duration = endDateTime.difference(startDateTime).inMinutes / 60.0;

      sleepData[dayIndex] += duration;
    }

    return sleepData;
  }

  // Helper function to parse time
  DateTime _parseTime(DateTime date, String time) {
    int hour = int.parse(time.split(':')[0]);
    int minute = int.parse(time.split(':')[1].split(' ')[0]);
    if (time.contains('PM') && hour != 12) hour += 12;
    if (time.contains('AM') && hour == 12) hour = 0;
    return DateTime(date.year, date.month, date.day, hour, minute);
  }

// Function to calculate average sleep time
  Future<double> _calculateAverageSleepTime() async {
    final today = DateTime.now();
    final startOfWeek = _getStartOfWeek(today);
    final endOfWeek = startOfWeek.add(Duration(days: 6));
    final sleepData = await _fetchSleepDataForWeek(startOfWeek, endOfWeek);
    final totalSleepTime = sleepData.reduce((sum, value) => sum + value);
    final averageSleepTime = sleepData.every((value) => value == 0.0)
        ? 0.0 // Explicitly make it a double
        : (totalSleepTime / sleepData.where((value) => value > 0).length);
    return averageSleepTime; // Now it's definitely a double
  }

  // Function to get the start date of the current week (Monday)
  DateTime _getStartOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  // Function to get the end date of the current week (Sunday)
  DateTime _getEndOfWeek(DateTime date) {
    return date.add(Duration(days: DateTime.daysPerWeek - date.weekday));
  }

  // Function to find the day with the highest sleep hours
  Future<MapEntry<DateTime, double>> _findDayWithHighestSleep() async {
    final today = DateTime.now();
    final startOfWeek = _getStartOfWeek(today);
    final endOfWeek = _getEndOfWeek(today);
    final sleepData = await _fetchSleepDataForWeek(startOfWeek, endOfWeek);

    DateTime highestSleepDate = startOfWeek; // Initialize with start of week
    double highestSleepHours = 0.0;

    for (int i = 0; i < sleepData.length; i++) {
      final currentDate = startOfWeek.add(Duration(days: i));
      if (sleepData[i] > highestSleepHours) {
        highestSleepHours = sleepData[i];
        highestSleepDate = currentDate;
      }
    }

    return MapEntry(highestSleepDate, highestSleepHours);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double titleFontSize = screenWidth * 0.06;
    double secondTitleFontSize = screenWidth * 0.05;
    double smallFontSize = screenWidth * 0.04;
    double bigFontSize = screenWidth * 0.07;
    double tinyFontSize = screenWidth * 0.03;

    final systemPadding = MediaQuery.of(context).padding;
    final parentPadding = const EdgeInsets.symmetric(horizontal: 20.0);

// Calculate available width
    final availableWidth = screenWidth -
        (systemPadding.left +
            systemPadding.right +
            parentPadding.left +
            parentPadding.right);

    return Scaffold(
        // Section 1: Title and Back Button
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
              'Your Sleeping Stats', // Updated title for this page
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),

        // Section 2: Sleeping Stats Contents
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              // Title
              children: [
                Text(
                  "HIGHLIGHTS",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: secondTitleFontSize,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Montserrat',
                  ),
                ),
                // HIGHLIGHTS Section
                FutureBuilder<MapEntry<DateTime, double>>(
                  future: _findDayWithHighestSleep(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    if (snapshot.hasError) {
                      return Text('Error calculating highlights');
                    }

                    final highestSleepData = snapshot.data;
                    final highestSleepDate = highestSleepData!.key;
                    final highestSleepHours = highestSleepData.value;

                    final formattedDate = DateFormat('MMMM dd')
                        .format(highestSleepDate); // Format: "Month Day"

                    return Text(
                      "On $formattedDate, You've slept ${highestSleepHours.toInt()} hours!",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: smallFontSize,
                        fontFamily: 'Montserrat',
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // Bar Graphs
                AspectRatio(
                  aspectRatio: 1.8,
                  child: FutureBuilder<List<double>>(
                    future: (() async {
                      final today = DateTime.now();
                      final startOfWeek = _getStartOfWeek(today);
                      final endOfWeek = _getEndOfWeek(today);
                      return await _fetchSleepDataForWeek(
                          startOfWeek, endOfWeek);
                    })(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return Center(child: Text('Error loading data'));
                      }

                      final sleepData = snapshot.data ?? List.filled(7, 0.0);
                      final maxY = (sleepData.reduce(
                                  (curr, next) => curr > next ? curr : next) *
                              1.2)
                          .ceilToDouble();

                      final today = DateTime.now();
                      final startOfWeek = _getStartOfWeek(today);

                      return BarChart(
                        BarChartData(
                          maxY: 10,
                          barGroups: _generateBarGroups(sleepData),
                          borderData: FlBorderData(show: false),
                          gridData: FlGridData(
                            drawHorizontalLine:
                                true, // Add horizontal grid lines
                            drawVerticalLine:
                                false, // Disable vertical grid lines
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                color: Colors.white12, // Light grid line color
                                strokeWidth: 1,
                              );
                            },
                          ),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 1, // Show titles at every interval
                                getTitlesWidget: (value, meta) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      value.toInt().toString(),
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: tinyFontSize),
                                    ),
                                  );
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  const days = [
                                    'MON',
                                    'TUE',
                                    'WED',
                                    'THU',
                                    'FRI',
                                    'SAT',
                                    'SUN'
                                  ];
                                  final date = startOfWeek
                                      .add(Duration(days: value.toInt()));
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Transform.scale(
                                            scale: 1.4,
                                            child: Text(
                                              days[value.toInt()],
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontSize: bigFontSize,
                                              ),
                                            ),
                                          ),
                                          Transform.scale(
                                            scale: 1.3,
                                            child: Text(
                                              "${date.day}/${date.month}",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontSize: bigFontSize,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            topTitles: AxisTitles(
                                sideTitles: SideTitles(
                                    showTitles: false)), // Hide top titles
                            rightTitles: AxisTitles(
                                sideTitles: SideTitles(
                                    showTitles: false)), // Hide right titles
                          ),
                          barTouchData: BarTouchData(enabled: false),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 30),

                // Average Sleep Time Content
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF26184A), // Purple card background
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      FutureBuilder<double>(
                        future: _calculateAverageSleepTime(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(); // Or a placeholder text
                          }

                          if (snapshot.hasError) {
                            return Text('Error calculating average');
                          }

                          return Text(
                            textAlign: TextAlign.center,
                            "AVG SLEEP TIME",
                            style: TextStyle(
                              fontSize: secondTitleFontSize,
                              color: Color(0xFFE4DCFF),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 10),

                      // Icons and Text
                      SizedBox(
                        // Added SizedBox for width
                        width: availableWidth,
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Center content horizontally
                            mainAxisSize:
                                MainAxisSize.min, // Row takes minimum space
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.alarm,
                                      color: Colors.white, size: 24),
                                  const SizedBox(width: 8),
                                  FutureBuilder<double>(
                                    future: _calculateAverageSleepTime(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator(); // Or a placeholder text
                                      }

                                      if (snapshot.hasError) {
                                        return Text('Error');
                                      }

                                      final averageSleepTime =
                                          snapshot.data ?? 0.0;
                                      return Text(
                                        "${averageSleepTime.toStringAsFixed(1)} HRS",
                                        style: TextStyle(
                                          fontSize: smallFontSize,
                                          color: Color(0xFFE4DCFF),
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(width: 20),
                              FutureBuilder<double>(
                                future: _calculateAverageSleepTime(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  }

                                  if (snapshot.hasError) {
                                    return Text('Error');
                                  }

                                  final averageSleepTime = snapshot.data ?? 0.0;
                                  final isSleepSufficient =
                                      averageSleepTime >= 7.0;

                                  return Row(
                                    children: [
                                      Icon(
                                        isSleepSufficient
                                            ? Icons.thumb_up
                                            : Icons
                                                .sentiment_neutral, // Use flat face emoji icon
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        isSleepSufficient
                                            ? "KEEP UP\nTHE GOOD WORK!"
                                            : "YOU NEED\nMORE SLEEP!",
                                        style: TextStyle(
                                          fontSize: tinyFontSize,
                                          color: Color(0xFFE4DCFF),
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                //Things you should do
                Text(
                  "Things you should do to keep your sleeping time good:",
                  style: TextStyle(
                      fontSize: smallFontSize,
                      color: Theme.of(context).colorScheme.primary,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  "• Drink more water\n• Breathing Exercise\n• Work on your thesis",
                  style: TextStyle(
                    fontSize: smallFontSize,
                    color: Theme.of(context).colorScheme.primary,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavbar(selectedIndex: 3),
          ),
          Positioned(
            bottom: 56,
            left: MediaQuery.of(context).size.width / 2 - 27,
            child: const PlusButton(
              targetPage: AddPlans(),
            ),
          ),
        ]));
  }

  List<BarChartGroupData> _generateBarGroups(List<double> sleepData) {
    return sleepData.asMap().entries.map((entry) {
      final index = entry.key;
      final value = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: value,
            color: Theme.of(context).colorScheme.primary,
            width: 20,
            borderRadius: BorderRadius.circular(6),
          ),
        ],
      );
    }).toList();
  }
}
