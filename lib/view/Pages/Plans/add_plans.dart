import 'package:flutter/material.dart';
// import 'package:sleepful/view/Pages/Plans/time_picker_page.dart';
import '../../Navbar/bottom_navbar.dart';
import '../../Components/plus_button.dart';
import '../../../controller/Plans/time_picker_controller.dart';
import '../../Components/plus_button.dart';
import '../../Navbar/bottom_navbar.dart';

class AddPlans extends StatefulWidget {
  const AddPlans({super.key});

  @override
  AddPlansState createState() => AddPlansState(); // Change to public
}

class AddPlansState extends State<AddPlans> {
  final TimePickerController controller = TimePickerController();
  final TextEditingController titleController = TextEditingController();

  // Change to public
  // bool isStartSelected = true; // Track if Start button is selected
  //
  // int selectedStartHour = 12; // Default hour for start
  // int selectedStartMinute = 0; // Default minute for start
  // int selectedEndHour = 12; // Default hour for end
  // int selectedEndMinute = 0; // Default minute for end
  // bool isStartAM = true; // Track AM/PM for start
  // bool isEndAM = true; // Track AM/PM for end
  //
  // int selectedHourIndex = 0; // Default selected hour index
  // int selectedMinuteIndex = 0; // Default selected minute index
  //
  // // void _toggleButton(bool isStart) {
  // //   setState(() {
  // //     isStartSelected = isStart; // Update the selected button state
  // //   });
  // // }
  //
  //
  //
  // int selectedHour = 12; // Default hour
  // int selectedMinute = 0; // Default minute
  // String selectedPeriod = 'AM';
  //
  // final List<int> hours = List.generate(24, (index) => (index % 12) + 1);
  // final List<int> minutes = List.generate(60, (index) => index % 60);
  // final List<String> periods = ['AM', 'PM'];
  //
  // // Use FixedExtentScrollController
  // final FixedExtentScrollController hourController =
  //     FixedExtentScrollController(initialItem: 12 + 5999);
  // final FixedExtentScrollController minuteController =
  //     FixedExtentScrollController(initialItem: 0 + 6000);
  // final FixedExtentScrollController periodController =
  //     FixedExtentScrollController(initialItem: 0);
  //
  // void resetTime() {
  //   setState(() {
  //     selectedHour = 12; // Reset to default hour
  //     selectedMinute = 0; // Reset to default minute
  //     selectedPeriod = 'AM';
  //   });
  //
  //   // Reset the scroll position
  //   hourController.jumpToItem(12 + 5999); // Reset to default hour
  //   minuteController.jumpToItem(0 + 6000); // Reset to default minute
  //   periodController.jumpToItem(0);
  // }
  // void _toggleButton(bool isStart) {
  //   setState(() {
  //     isStartSelected = isStart; // Update the selected button state
  //     selectedHour = 12; // Reset to default hour
  //     selectedMinute = 0; // Reset to default minute
  //     selectedPeriod = 'AM';
  //   });
  //   hourController.jumpToItem(12 + 5999); // Reset to default hour
  //   minuteController.jumpToItem(0 + 6000); // Reset to default minute
  //   periodController.jumpToItem(0);
  // }

  @override
  void dispose() {
    controller.hourController.dispose();
    controller.minuteController.dispose();
    controller.periodController.dispose();
    titleController.dispose();
    super.dispose();
  }

  // void _updateStartTime(int hour, int minute, bool isAM) {
  //   setState(() {
  //     selectedStartHour = hour;
  //     selectedStartMinute = minute;
  //     isStartAM = isAM;
  //   });
  // }
  //
  // void _updateEndTime(int hour, int minute, bool isAM) {
  //   setState(() {
  //     selectedEndHour = hour;
  //     selectedEndMinute = minute;
  //     isEndAM = isAM;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder: (context, innerIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
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
                      'Add Plans',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  centerTitle: false,
                  floating: false,
                  snap: false,
                  pinned: false,
                  forceElevated: innerIsScrolled,
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Time Picker Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Hour Picker
                      SizedBox(
                        width: 100,
                        height: 200,
                        child: ListWheelScrollView.useDelegate(
                          // controller: hourController,
                          controller: controller.hourController,
                          itemExtent: 80,
                          physics: FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            // setState(() {
                            //   selectedHourIndex =
                            //       index; // Update selected hour index
                            //   selectedStartHour = (index % 12) +
                            //       1; // Update selected hour value
                            // });
                            setState(() {
                              // selectedHour = hours[index % hours.length];
                              controller.selectedHour = controller
                                  .hours[index % controller.hours.length];
                            });
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              // int hour = (index % 12) + 1;
                              // bool isSelected =
                              //     (hours[index % hours.length] == selectedHour);
                              bool isSelected = (controller
                                      .hours[index % controller.hours.length] ==
                                  controller.selectedHour);
                              return Container(
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.onError
                                      : Colors.transparent,
                                  // Change color if selected
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ), // Optional: Add some rounding
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  // hours[index % hours.length]
                                  //     .toString()
                                  controller
                                      .hours[index % controller.hours.length]
                                      .toString()
                                      .padLeft(2, '0'),
                                  style: TextStyle(
                                    fontSize: 54,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                    color: isSelected
                                        ? Colors.white
                                        : Theme.of(context)
                                            .colorScheme
                                            .onErrorContainer, // Change text color if selected
                                  ),
                                ),
                              );
                            },
                            // childCount: hours.length * 1000,
                            childCount: controller.hours.length * 1000,
                          ),
                        ),
                      ),
                      // Colon
                      SizedBox(
                        width: 20, // Set a width for the colon
                        height: 80, // Set a height for the colon
                        child: Container(
                          decoration: BoxDecoration(
                            color: (controller.selectedHour != -1 ||
                                    controller.selectedMinute != -1)
                                ? Theme.of(context)
                                    .colorScheme
                                    .onError // Change color if hour or minute is selected
                                : Colors.transparent, // Default color
                            borderRadius:
                                BorderRadius.circular(0), // No rounding
                          ),
                          alignment: Alignment.center,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Invisible number on the left
                              Text(
                                '1',
                                style: TextStyle(
                                  fontSize: 32,
                                  color: Colors
                                      .transparent, // Make the number invisible
                                ),
                              ),
                              // Visible colon
                              Text(
                                ':',
                                style: TextStyle(
                                    fontSize: 54,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                    color: Colors.white),
                              ),
                              // Invisible number on the right
                              Text(
                                '1',
                                style: TextStyle(
                                  fontSize: 32,
                                  color: Colors
                                      .transparent, // Make the number invisible
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Minute Picker
                      SizedBox(
                        width: 100,
                        height: 200,
                        child: ListWheelScrollView.useDelegate(
                          controller: controller.minuteController,
                          itemExtent: 80,
                          physics: const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            // setState(() {
                            //   selectedMinuteIndex =
                            //       index; // Update selected minute index
                            //   selectedStartMinute =
                            //       index % 60; // Update selected minute value
                            // });
                            setState(() {
                              controller.selectedMinute = controller
                                  .minutes[index % controller.minutes.length];
                            });
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              bool isSelected = (controller.minutes[
                                      index % controller.minutes.length] ==
                                  controller.selectedMinute);
                              // int minute = index % 60;
                              return Container(
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.onError
                                      : Colors.transparent,
                                  // Change color if selected
                                  borderRadius: BorderRadius.circular(
                                      0), // Optional: Add some rounding
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  controller.minutes[
                                          index % controller.minutes.length]
                                      .toString()
                                      .padLeft(2, '0'),
                                  style: TextStyle(
                                    fontSize: 54,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                    color: isSelected
                                        ? Colors.white
                                        : Theme.of(context)
                                            .colorScheme
                                            .onErrorContainer, // Change text color if selected
                                  ),
                                ),
                              );
                            },
                            childCount: controller.minutes.length * 200,
                          ),
                        ),
                      ),
                      // AM/PM Selector
                      SizedBox(
                        width: 110,
                        height: 200,
                        child: ListWheelScrollView.useDelegate(
                          controller: controller.periodController,
                          itemExtent: 80,
                          physics: FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            // setState(() {
                            //   isStartAM = index == 0; // Update AM/PM selection
                            // });
                            setState(() {
                              controller.selectedPeriod =
                                  controller.periods[index];
                            });
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              bool isSelected = (controller.periods[index] ==
                                  controller.selectedPeriod);
                              // String period = index % 2 == 0 ? 'AM' : 'PM';
                              return Container(
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.onError
                                      : Colors.transparent,
                                  // Change color if selected
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ), // Optional: Add some rounding
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  controller.periods[index],
                                  style: TextStyle(
                                    fontSize: 54,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                    color: isSelected
                                        ? Colors.white
                                        : Theme.of(context)
                                            .colorScheme
                                            .onErrorContainer, // Change text color if selected
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
                  const SizedBox(height: 20),

                  // Pick a Day Section with Buttons
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF1F1249),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  controller.switchToStart();
                                });
                              },
                              // onPressed: () => _toggleButton(true),
                              // onPressed: resetTime,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: controller.isStartSelected
                                    ? Color(0xFFB4A9D6)
                                    : Colors.transparent,
                                foregroundColor: controller.isStartSelected
                                    ? Color(0xFF1F1249)
                                    : Colors.white,
                                side: BorderSide(
                                  color: controller.isStartSelected
                                      ? Color(
                                          0xFFB4A9D6) // Change border color to B4A9D6 when selected
                                      : Colors.white,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 4.0),
                              ),
                              child: const Text(
                                'Start',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  controller.switchToEnd();
                                });
                              },
                              // onPressed: () => _toggleButton(false),
                              // onPressed: resetTime,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: !controller.isStartSelected
                                    ? Color(0xFFB4A9D6)
                                    : Colors.transparent,
                                foregroundColor: !controller.isStartSelected
                                    ? Color(0xFF1F1249)
                                    : Colors.white,
                                side: BorderSide(color: Colors.white),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 35.0, vertical: 4.0),
                              ),
                              child: const Text(
                                'End',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        const Text('Pick a Day',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              fontSize: 20,
                            )),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // children: const [
                          //   DayCircle(letter: 'S'),
                          //   DayCircle(letter: 'M'),
                          //   DayCircle(letter: 'T'),
                          //   DayCircle(letter: 'W'),
                          //   DayCircle(letter: 'T'),
                          //   DayCircle(letter: 'F'),
                          //   DayCircle(letter: 'S'),
                          // ],
                          children: List.generate(7, (index) {
                            String dayLetter = ['S', 'M', 'T', 'W', 'T', 'F', 'S'][index];
                            return DayCircle(
                              letter: dayLetter,
                              isSelected: controller.selectedDays[index],
                              onSelected: (isSelected) {
                                setState(() {
                                  controller.selectedDays[index] = isSelected; // Update the selected day
                                });
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Name Your Plan Section
                  Align(
                    alignment: Alignment.centerLeft, // Align to the left
                    child: Text(
                      'Name Your Plan',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: titleController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      // Set the bottom border to be visible
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width:
                                2.0), // Set the bottom border color and width
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width:
                                2.0), // Set the focused bottom border color and width
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red,
                            width:
                                2.0), // Set the error bottom border color and width
                      ),
                      hintText: 'Enter plan name',
                      hintStyle: TextStyle(
                          color: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.color), // Optional: Change hint text color
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Add Button
                  ElevatedButton(
                    // onPressed: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const TimePickerPage()),
                    //   );
                    // },
                    onPressed: () {
                      setState(() {
                        controller.validateTimes(context, titleController.text);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.error,
                      foregroundColor: Colors.white,
                      // Same foreground color as Start button
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35.0,
                          vertical: 4.0), // Same padding as Start button
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    'Selected Time: ${controller.selectedHour.toString().padLeft(2, '0')}:${controller.selectedMinute.toString().padLeft(2, '0')} ${controller.selectedPeriod}',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  Text('Start Time: ${controller.startTime}',
                      style: TextStyle(fontSize: 12, color: Colors.white)),
                  Text('End Time: ${controller.endTime}',
                      style: TextStyle(fontSize: 12, color: Colors.white)),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavbar(selectedIndex: -1),
          ),
          Positioned(
            bottom: 56,
            left: MediaQuery.of(context).size.width / 2 - 27,
            child: const PlusButton(),
          ),
        ],
      ),
    );
  }
}

class DayCircle extends StatefulWidget {
  final String letter;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const DayCircle({
    super.key,
    required this.letter,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  DayCircleState createState() => DayCircleState();
}

class DayCircleState extends State<DayCircle> {
  // bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // isSelected = !isSelected;
          widget.onSelected(!widget.isSelected);
        });
      },
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.isSelected ? Color(0xFFB4A9D6) : Colors.transparent,
          border: Border.all(
            color: widget.isSelected ? Color(0xFFB4A9D6) : Colors.white,
            width: 2.0,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          widget.letter,
          style: TextStyle(
            color: widget.isSelected ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
