import 'package:flutter/material.dart';
import '../../Navbar/bottom_navbar.dart';
import '../../Components/plus_button.dart';

class AddPlans extends StatefulWidget {
  const AddPlans({super.key});

  @override
  _AddPlansState createState() => _AddPlansState();
}

class _AddPlansState extends State<AddPlans> {
  bool isStartSelected = false; // Track if Start button is selected

  void _toggleButton(bool isStart) {
    setState(() {
      isStartSelected = isStart; // Update the selected button state
    });
  }

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
                    child: const Text(
                      'Add Plans',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Color(0xFFB4A9D6),
                      ),
                    ),
                  ),
                  centerTitle: false,
                  floating: true,
                  snap: true,
                  pinned: false,
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Time Picker Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Hour Picker
                      SizedBox(
                        width: 100,
                        height: 150,
                        child: ListWheelScrollView.useDelegate(
                          itemExtent: 50,
                          physics: const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            // Handle hour selection
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              int hour = (index % 12) + 1;
                              return Center(
                                child: Text(
                                  hour.toString().padLeft(2, '0'),
                                  style: TextStyle(
                                    fontSize: 32,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const Text(':',
                          style: TextStyle(fontSize: 32, color: Colors.white)),
                      // Minute Picker
                      SizedBox(
                        width: 100,
                        height: 150,
                        child: ListWheelScrollView.useDelegate(
                          itemExtent: 50,
                          physics: const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            // Handle minute selection
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              int minute = index % 60;
                              return Center(
                                child: Text(
                                  minute.toString().padLeft(2, '0'),
                                  style: TextStyle(
                                    fontSize: 32,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      // AM/PM Selector
                      SizedBox(
                        width: 70,
                        height: 150,
                        child: ListWheelScrollView.useDelegate(
                          itemExtent: 50,
                          physics: const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            // Handle AM/PM selection
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              String period = index % 2 == 0 ? 'AM' : 'PM';
                              return Center(
                                child: Text(
                                  period,
                                  style: TextStyle(
                                    fontSize: 32,
                                    color: Colors.white,
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
                                backgroundColor: isStartSelected ? Color(0xFFB4A9D6) : Colors.transparent,
                                foregroundColor: isStartSelected ? Color(0xFF1F1249) : Colors.white,
                                side: BorderSide(color: Colors.white),
                                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 4.0),
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
                                backgroundColor: !isStartSelected ? Color(0xFFB4A9D6) : Colors.transparent,
                                foregroundColor: !isStartSelected ? Color(0xFF1F1249) : Colors.white,
                                side: BorderSide(color: Colors.white),
                                padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 4.0),
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
                            _DayCircle(letter: 'S'),
                            _DayCircle(letter: 'M'),
                            _DayCircle(letter: 'T'),
                            _DayCircle(letter: 'W'),
                            _DayCircle(letter: 'T'),
                            _DayCircle(letter: 'F'),
                            _DayCircle(letter: 'S'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Name Your Plan Section
                  Align(
                    alignment: Alignment.centerLeft, // Align to the left
                    child: const Text(
                      'Name Your Plan',
                      style: TextStyle(
                        color: Color(0xFFE4DCFF),
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
                        borderSide: BorderSide(color: Color(0xFFB4A9D6), width: 2.0), // Set the bottom border color and width
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFB4A9D6), width: 2.0), // Set the focused bottom border color and width
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0), // Set the error bottom border color and width
                      ),
                      hintText: 'Enter plan name',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)), // Optional: Change hint text color
                    ),
                  ),
                  const SizedBox(height: 20),

                  //Add Button
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6149A7), // Same background color as Start button
                      foregroundColor: Color(0xFF1F1249), // Same foreground color as Start button
                      padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 4.0), // Same padding as Start button
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

class _DayCircle extends StatefulWidget {
  final String letter;

  const _DayCircle({required this.letter});

  @override
  _DayCircleState createState() => _DayCircleState();
}

class _DayCircleState extends State<_DayCircle> {
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
          color: isSelected ? Colors.white : Colors.transparent,
          border: Border.all(
            color: Colors.white,
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