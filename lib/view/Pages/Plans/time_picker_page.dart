// import 'package:flutter/material.dart';
// import 'time_picker_controller.dart';
//
// class TimePickerPage extends StatefulWidget {
//   const TimePickerPage({super.key});
//
//   @override
//   TimePickerPageState createState() => TimePickerPageState();
// }
//
// class TimePickerPageState extends State<TimePickerPage> {
  // int selectedHour = 12; // Default hour
  // int selectedMinute = 0; // Default minute
  // String selectedPeriod = 'AM';
  //
  // // Store selected times for start and end
  // String startTime = '12:00 AM';
  // String endTime = '12:00 AM';
  //
  // bool isStartSelected = true; // Track which button is selected
  // String successMessage = '';
  //
  // final List<int> hours = List.generate(12, (index) => index + 1);
  // final List<int> minutes = List.generate(60, (index) => index);
  // final List<String> periods = ['AM', 'PM'];
  //
  // // Use FixedExtentScrollController
  // final FixedExtentScrollController hourController =
  // FixedExtentScrollController(initialItem: 12 + 5999);
  // final FixedExtentScrollController minuteController =
  // FixedExtentScrollController(initialItem: 0 + 6000);
  // final FixedExtentScrollController periodController =
  // FixedExtentScrollController(initialItem: 0);
  //
  // void resetTime(bool isStart) {
  //   if (isStart) {
  //     // Reset to the last selected start time
  //     List<String> startParts = startTime.split(':');
  //     selectedHour = int.parse(startParts[0]);
  //     selectedMinute = int.parse(startParts[1].split(' ')[0]);
  //     selectedPeriod = startParts[1].split(' ')[1];
  //   } else {
  //     // Reset to the last selected end time
  //     List<String> endParts = endTime.split(':');
  //     selectedHour = int.parse(endParts[0]);
  //     selectedMinute = int.parse(endParts[1].split(' ')[0]);
  //     selectedPeriod = endParts[1].split(' ')[1];
  //   }
  //
  //   // Reset the scroll position based on the selected time
  //   hourController.jumpToItem((selectedHour) + 5999); // Adjust for the scroll position
  //   minuteController.jumpToItem(selectedMinute + 6000); // Adjust for the scroll position
  //   periodController.jumpToItem(periods.indexOf(selectedPeriod)); // Adjust for the scroll position
  // }
  //
  // void switchToStart() {
  //   // Save the current time when switching to Start
  //   if (!isStartSelected) {
  //     endTime = '${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')} $selectedPeriod';
  //     resetTime(true); // Reset time picker for Start
  //   } else {
  //     resetTime(true); // Set the time picker to the last selected start time
  //   }
  //   setState(() {
  //     isStartSelected = true;
  //   });
  // }
  //
  // void switchToEnd() {
  //   // Save the current time when switching to End
  //   if (isStartSelected) {
  //     startTime = '${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')} $selectedPeriod';
  //     resetTime(false); // Reset time picker for End
  //   } else {
  //     resetTime(false); // Set the time picker to the last selected end time
  //   }
  //   setState(() {
  //     isStartSelected = false;
  //   });
  // }
  //
  //   void validateTimes() {
  //     // Save the latest selected time based on which button was last pressed
  //     if (isStartSelected) {
  //       startTime = '${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')} $selectedPeriod';
  //     } else {
  //       endTime = '${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')} $selectedPeriod';
  //     }
  //
  //     // Parse start and end times
  //     DateTime startDateTime = _parseTime(startTime);
  //     DateTime endDateTime = _parseTime(endTime);
  //
  //     // Check conditions
  //     if (endDateTime.isBefore(startDateTime)) {
  //       // If end time is before start time, add one day to end time
  //       endDateTime = endDateTime.add(Duration(days: 1));
  //     }
  //
  //
  //     // Calculate duration in minutes
  //     Duration duration = endDateTime.difference(startDateTime);
  //
  //     // String durationText = '${duration.inHours} hours and ${duration.inMinutes.remainder(60)} minutes';
  //     //
  //     // // Debugging: Print the duration
  //     // print('Duration: $durationText');
  //
  //     // Check conditions
  //     if (startDateTime.isAtSameMomentAs(endDateTime)) {
  //       setState(() {
  //         successMessage = 'Start time and end time cannot be the same.';
  //       });
  //       return;
  //     }
  //
  //     if (duration.inMinutes < 30) {
  //       setState(() {
  //         successMessage = 'Minimum duration of sleep is 30 minutes.';
  //       });
  //       return;
  //     }
  //
  //     if (duration.inHours >= 9 && duration.inMinutes.remainder(60) > 0) {
  //       setState(() {
  //         successMessage = 'Maximum duration of sleep is 9 hours.';
  //       });
  //       return;
  //     }
  //
  //     // If all conditions are met
  //     setState(() {
  //       successMessage = 'Success! Your sleep duration is valid.';
  //     });
  //   }
  //
  // DateTime _parseTime(String time) {
  //   // Parse the time string into a DateTime object
  //   List<String> parts = time.split(':');
  //   int hour = int.parse(parts[0]);
  //   int minute = int.parse(parts[1].split(' ')[0]);
  //   String period = parts[1].split(' ')[1];
  //
  //   // Adjust hour based on AM/PM
  //   if (period == 'PM' && hour != 12) {
  //     hour += 12;
  //   } else if (period == 'AM' && hour == 12) {
  //     hour = 0;
  //   }
  //
  //   return DateTime(0, 1, 1, hour, minute); // Year, Month, Day are arbitrary
  // }

//   @override
//   void dispose() {
//     hourController.dispose();
//     minuteController.dispose();
//     periodController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Time Picker'),
//         backgroundColor: Colors.blue, // You can customize the app bar color
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 width: 100,
//                 height: 200,
//                 child: ListWheelScrollView.useDelegate(
//                   controller: hourController,
//                   itemExtent: 40,
//                   physics: FixedExtentScrollPhysics(),
//                   onSelectedItemChanged: (index) {
//                     setState(() {
//                       selectedHour = hours[index % hours.length]; // Looping behavior
//                     });
//                   },
//                   childDelegate: ListWheelChildBuilderDelegate(
//                     builder: (context, index) {
//                       bool isSelected = (hours[index % hours.length] == selectedHour);
//                       return Container(
//                         decoration: BoxDecoration(
//                           color: isSelected ? Colors.red : Colors.transparent,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Center(
//                           child: Text(
//                             hours[index % hours.length].toString(),
//                             style: TextStyle(
//                               fontSize: 24,
//                               color: isSelected
//                                   ? Colors.white
//                                   : Colors.white.withOpacity(0.5),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                     childCount: hours.length * 1000,
//                   ),
//                 ),
//               ),
//               SizedBox(width: 20),
//               SizedBox(
//                 width: 100,
//                 height: 200,
//                 child: ListWheelScrollView.useDelegate(
//                   controller: minuteController,
//                   itemExtent: 40,
//                   physics: FixedExtentScrollPhysics(),
//                   onSelectedItemChanged: (index) {
//                     setState(() {
//                       selectedMinute = minutes[index % minutes.length]; // Looping behavior
//                     });
//                   },
//                   childDelegate: ListWheelChildBuilderDelegate(
//                     builder: (context, index) {
//                       bool isSelected = (minutes[index % minutes.length] == selectedMinute);
//                       return Container(
//                         decoration: BoxDecoration(
//                           color: isSelected ? Colors.red : Colors.transparent,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Center(
//                           child: Text(
//                             minutes[index % minutes.length].toString(),
//                             style: TextStyle(
//                               fontSize: 24,
//                               color: isSelected
//                                   ? Colors.white
//                                   : Colors.white.withOpacity(0.5),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                     childCount: minutes.length * 1000,
//                   ),
//                 ),
//               ),
//               SizedBox(width: 20),
//               SizedBox(
//                 width: 100,
//                 height: 200,
//                 child: ListWheelScrollView.useDelegate(
//                   controller: periodController,
//                   itemExtent: 40,
//                   physics: FixedExtentScrollPhysics(),
//                   onSelectedItemChanged: (index) {
//                     setState(() {
//                       selectedPeriod = periods[index]; // Update selected period
//                     });
//                   },
//                   childDelegate: ListWheelChildBuilderDelegate(
//                     builder: (context, index) {
//                       bool isSelected = (periods[index] == selectedPeriod);
//                       return Container(
//                         decoration: BoxDecoration(
//                           color: isSelected ? Colors.red : Colors.transparent,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Center(
//                           child: Text(
//                             periods[index],
//                             style: TextStyle(
//                               fontSize: 24,
//                               color: isSelected
//                                   ? Colors.white
//                                   : Colors.white.withOpacity(0.5),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                     childCount: periods.length,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: switchToStart,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: isStartSelected ? Colors.green : Colors.blue,
//                 ),
//                 child: Text('Start', style: TextStyle(color: Colors.white),),
//               ),
//               SizedBox(width: 20),
//               ElevatedButton(
//                 onPressed: switchToEnd,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: !isStartSelected ? Colors.green : Colors.blue,
//                 ),
//                 child: Text('End', style: TextStyle(color: Colors.white),),
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: validateTimes,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.orange,
//             ),
//             child: Text('Validate Sleep Duration', style: TextStyle(color: Colors.white)),
//           ),
//           SizedBox(height: 20),
//           Text('Start Time: $startTime', style: TextStyle(fontSize: 20, color: Colors.white)),
//           Text('End Time: $endTime', style: TextStyle(fontSize: 20, color: Colors.white)),
//           Text(
//             'Selected Time: ${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')} $selectedPeriod',
//             style: TextStyle(fontSize: 24, color: Colors.white),
//           ),
//           SizedBox(height: 20),
//           Text(successMessage, style: TextStyle(fontSize: 20, color: Colors.green)),
//         ],
//       ),
//     );
//   }
// }
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