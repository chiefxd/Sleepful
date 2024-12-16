import 'package:flutter/material.dart';
import '../../../controller/Plans/time_picker_controller.dart';

class TimePickerPage extends StatefulWidget {
  const TimePickerPage({super.key});

  @override
  TimePickerPageState createState() => TimePickerPageState();
}

class TimePickerPageState extends State<TimePickerPage> {
  final TimePickerController controller = TimePickerController();

  @override
  void dispose() {
    controller.hourController.dispose();
    controller.minuteController.dispose();
    controller.periodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Picker'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 200,
                child: ListWheelScrollView.useDelegate(
                  controller: controller.hourController,
                  itemExtent: 40,
                  physics: FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      controller.selectedHour = controller.hours[index % controller.hours.length]; // Looping behavior
                    });
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      bool isSelected = (controller.hours[index % controller.hours.length] == controller.selectedHour);
                      return Container(
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.red : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            controller.hours[index % controller.hours.length].toString(),
                            style: TextStyle(
                              fontSize: 24,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: controller.hours.length * 1000,
                  ),
                ),
              ),
              SizedBox(width: 20),
              SizedBox(
                width: 100,
                height: 200,
                child: ListWheelScrollView.useDelegate(
                  controller: controller.minuteController,
                  itemExtent: 40,
                  physics: FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      controller.selectedMinute = controller.minutes[index % controller.minutes.length]; // Looping behavior
                    });
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      bool isSelected = (controller.minutes[index % controller.minutes.length] == controller.selectedMinute);
                      return Container(
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.red : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            controller.minutes[index % controller.minutes.length].toString(),
                            style: TextStyle(
                              fontSize: 24,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: controller.minutes.length * 1000,
                  ),
                ),
              ),
              SizedBox(width: 20),
              SizedBox(
                width: 100,
                height: 200,
                child: ListWheelScrollView.useDelegate(
                  controller: controller.periodController,
                  itemExtent: 40,
                  physics: FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      controller.selectedPeriod = controller.periods[index]; // Update selected period
                    });
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      bool isSelected = (controller.periods[index] == controller.selectedPeriod);
                      return Container(
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.red : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            controller.periods[index],
                            style: TextStyle(
                              fontSize: 24,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: controller.periods.length,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    controller.switchToStart();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: controller.isStartSelected ? Colors.green : Colors.blue,
                ),
                child: Text('Start', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    controller.switchToEnd();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: !controller.isStartSelected ? Colors.green : Colors.blue,
                ),
                child: Text('End', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                controller.validateTimes(context, "Hello");
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
            child: Text('Validate Sleep Duration', style: TextStyle(color: Colors.white)),
          ),
          SizedBox(height: 20),
          Text('Start Time: ${controller.startTime}', style: TextStyle(fontSize: 20, color: Colors.white)),
          Text('End Time: ${controller.endTime}', style: TextStyle(fontSize: 20, color: Colors.white)),
          Text(
            'Selected Time: ${controller.selectedHour.toString().padLeft(2, '0')}:${controller.selectedMinute.toString().padLeft(2, '0')} ${controller.selectedPeriod}',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          SizedBox(height: 20),
          Text(controller.successMessage, style: TextStyle(fontSize: 20, color: Colors.green)),
        ],
      ),
    );
  }
}