import 'package:flutter/material.dart';

import '../../Components/plus_button.dart';
import '../../Navbar/bottom_navbar.dart';

class AddPlans extends StatefulWidget {
  const AddPlans({super.key});

  @override
  AddPlansState createState() => AddPlansState(); // Change to public
}

class AddPlansState extends State<AddPlans> {
  // Change to public
  bool isStartSelected = true; // Track if Start button is selected

  int selectedStartHour = 12; // Default hour for start
  int selectedStartMinute = 0; // Default minute for start
  int selectedEndHour = 12; // Default hour for end
  int selectedEndMinute = 0; // Default minute for end
  bool isStartAM = true; // Track AM/PM for start
  bool isEndAM = true; // Track AM/PM for end

  int selectedHourIndex = 0; // Default selected hour index
  int selectedMinuteIndex = 0; // Default selected minute index

  void _toggleButton(bool isStart) {
    setState(() {
      isStartSelected = isStart; // Update the selected button state
    });
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
                          itemExtent: 80,
                          physics: const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              selectedHourIndex =
                                  index; // Update selected hour index
                              selectedStartHour = (index % 12) +
                                  1; // Update selected hour value
                            });
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              int hour = (index % 12) + 1;
                              return Container(
                                decoration: BoxDecoration(
                                  color: index == selectedHourIndex
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
                                  hour.toString().padLeft(2, '0'),
                                  style: TextStyle(
                                    fontSize: 54,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                    color: index == selectedHourIndex
                                        ? Colors.white
                                        : Theme.of(context)
                                            .colorScheme
                                            .onErrorContainer, // Change text color if selected
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      // Colon
                      SizedBox(
                        width: 20, // Set a width for the colon
                        height: 80, // Set a height for the colon
                        child: Container(
                          decoration: BoxDecoration(
                            color: (selectedHourIndex != -1 ||
                                    selectedMinuteIndex != -1)
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
                          itemExtent: 80,
                          physics: const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              selectedMinuteIndex =
                                  index; // Update selected minute index
                              selectedStartMinute =
                                  index % 60; // Update selected minute value
                            });
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              int minute = index % 60;
                              return Container(
                                decoration: BoxDecoration(
                                  color: index == selectedMinuteIndex
                                      ? Theme.of(context).colorScheme.onError
                                      : Colors.transparent,
                                  // Change color if selected
                                  borderRadius: BorderRadius.circular(
                                      0), // Optional: Add some rounding
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  minute.toString().padLeft(2, '0'),
                                  style: TextStyle(
                                    fontSize: 54,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                    color: index == selectedMinuteIndex
                                        ? Colors.white
                                        : Theme.of(context)
                                            .colorScheme
                                            .onErrorContainer, // Change text color if selected
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      // AM/PM Selector
                      SizedBox(
                        width: 110,
                        height: 200,
                        child: ListWheelScrollView.useDelegate(
                          itemExtent: 80,
                          physics: const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              isStartAM = index == 0; // Update AM/PM selection
                            });
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              String period = index % 2 == 0 ? 'AM' : 'PM';
                              return Container(
                                decoration: BoxDecoration(
                                  color: isStartAM == (index == 0)
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
                                  period,
                                  style: TextStyle(
                                    fontSize: 54,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                    color: isStartAM == (index == 0)
                                        ? Colors.white
                                        : Theme.of(context)
                                            .colorScheme
                                            .onErrorContainer, // Change text color if selected
                                  ),
                                ),
                              );
                            },
                            childCount: 2,
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
                              onPressed: () => _toggleButton(true),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isStartSelected
                                    ? Color(0xFFB4A9D6)
                                    : Colors.transparent,
                                foregroundColor: isStartSelected
                                    ? Color(0xFF1F1249)
                                    : Colors.white,
                                side: BorderSide(
                                  color: isStartSelected
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
                              onPressed: () => _toggleButton(false),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: !isStartSelected
                                    ? Color(0xFFB4A9D6)
                                    : Colors.transparent,
                                foregroundColor: !isStartSelected
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
                          children: const [
                            DayCircle(letter: 'S'),
                            DayCircle(letter: 'M'),
                            DayCircle(letter: 'T'),
                            DayCircle(letter: 'W'),
                            DayCircle(letter: 'T'),
                            DayCircle(letter: 'F'),
                            DayCircle(letter: 'S'),
                          ],
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
                    onPressed: () {},
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

  const DayCircle({super.key, required this.letter});

  @override
  DayCircleState createState() => DayCircleState();
}

class DayCircleState extends State<DayCircle> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Color(0xFFB4A9D6) : Colors.transparent,
          border: Border.all(
            color: isSelected ? Color(0xFFB4A9D6) : Colors.white,
            width: 2.0,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          widget.letter,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
