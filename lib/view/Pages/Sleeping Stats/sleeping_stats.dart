import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SleepingStats extends StatefulWidget {
  const SleepingStats({super.key});

  @override
  State<SleepingStats> createState() => _SleepingStatsState();
}

class _SleepingStatsState extends State<SleepingStats> {
  // Dummy data for hours of sleep
  final List<double> sleepData = [5, 9, 7, 8, 10, 4, 6];

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
      body: Padding(
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
            Text(
              "On March 18th 2024, You've slept 9 hours!",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: smallFontSize,
                fontFamily: 'Montserrat',
              ),
            ),

            const SizedBox(height: 20),

            // Bar Graphs
            AspectRatio(
              aspectRatio: 1.8,
              child: BarChart(
                BarChartData(
                  maxY: 10,
                  barGroups: _generateBarGroups(),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(
                    drawHorizontalLine: true, // Add horizontal grid lines
                    drawVerticalLine: false, // Disable vertical grid lines
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
                                  color: Theme.of(context).colorScheme.primary,
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
                            'SUN',
                            'MON',
                            'TUE',
                            'WED',
                            'THU',
                            'FRI',
                            'SAT'
                          ];
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
                                      "${17 + value.toInt()}/3",
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
                        sideTitles:
                            SideTitles(showTitles: false)), // Hide top titles
                    rightTitles: AxisTitles(
                        sideTitles:
                            SideTitles(showTitles: false)), // Hide right titles
                  ),
                  barTouchData: BarTouchData(enabled: false),
                ),
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
                  Text(
                    textAlign: TextAlign.center,
                    "AVG SLEEP TIME",
                    style: TextStyle(
                      fontSize: secondTitleFontSize,
                      color: Color(0xFFE4DCFF),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
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
                              Icon(Icons.alarm, color: Colors.white, size: 24),
                              const SizedBox(width: 8),
                              Text(
                                "7.5 HRS",
                                style: TextStyle(
                                  fontSize: smallFontSize,
                                  color: Color(0xFFE4DCFF),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Row(
                            children: [
                              Icon(Icons.thumb_up,
                                  color: Colors.white, size: 24),
                              const SizedBox(width: 8),
                              Text(
                                "KEEP UP\nTHE GOOD WORK!",
                                style: TextStyle(
                                  fontSize: tinyFontSize,
                                  color: Color(0xFFE4DCFF),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
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
    );
  }

  List<BarChartGroupData> _generateBarGroups() {
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
