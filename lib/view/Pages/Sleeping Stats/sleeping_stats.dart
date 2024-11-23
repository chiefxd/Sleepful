import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SleepingStats extends StatefulWidget {
  final int selectedIndex;

  const SleepingStats({super.key, this.selectedIndex = 3});

  @override
  State<SleepingStats> createState() => _SleepingStatsState();
}

class _SleepingStatsState extends State<SleepingStats> {
  // Sample sleep data (replace with your actual data)
  final List<ChartData> chartData = [
    ChartData('SUN 17/3', 1),
    ChartData('MON 18/3', 6),
    ChartData('TUE 19/3', 8),
    ChartData('WED 20/3', 5),
    ChartData('THU 21/3', 9),
    ChartData('FRI 22/3', 4),
    ChartData('SAT 23/3', 7),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          primaryYAxis: NumericAxis(
            minimum: 0,
            maximum: 10,
            interval: 1,
          ),
          plotAreaBorderWidth: 0,
          isTransposed: true,
          series: <ChartSeries>[
            BarSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              width: 0.4,
            ),
          ],
        ),
      ),
    );
  }
}

// Data model for the chart
class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}
