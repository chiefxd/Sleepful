import 'package:flutter/material.dart';
import 'package:sleepful/view/Pages/Plans/update_plans.dart';

import '../../Components/plus_button.dart';
import '../../Navbar/bottom_navbar.dart';

class ViewPlans extends StatelessWidget {
  const ViewPlans({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // Use Stack to position the PlusButton
        children: [
          NestedScrollView(
            headerSliverBuilder: (context, innerIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pop(); // Go back to the previous screen
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        'assets/images/buttonBack.png',
                        // Use the same back button image
                        width: 48,
                        height: 48,
                      ),
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Text(
                      'Your Plans',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        // Ensure the same font family is used
                        color: Theme.of(context)
                            .colorScheme
                            .primary, // Use the same color as in profile.dart
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
            body: Column(
              children: [
                // List of Plans
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      _buildPlanCard(
                          context, 'Plan Title 1', '2:00 AM - 11:00 AM'),
                      _buildPlanCard(
                          context, 'Plan Title 2', '3:00 AM - 12:00 PM'),
                      _buildPlanCard(
                          context, 'Plan Title 3', '4:00 AM - 1:00 PM'),
                    ],
                  ),
                ),
                BottomNavbar(selectedIndex: -1),
              ],
            ),
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
              child: Row(
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
                  InkWell(
                    onTap: () {
                      // Show confirmation dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Color(0xFF1F1249),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              // Use minimum size for the column
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.delete, // Use the delete icon
                                      color: Color(0xFFB4A9D6),
                                      size: 30, // Adjust the size as needed
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                // Add some space between the icon and text
                                Text(
                                  'Are you sure you want to delete $title?',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            actions: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        // Background color
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        // Rounded corners
                                        border: Border.all(
                                          color: Color(0xFFB4A9D6),
                                          // Border color
                                          width: 2.0, // Border width
                                        ),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          // Vertical padding
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                30.0), // Rounded corners
                                          ),
                                        ),
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Montserrat',
                                            // Montserrat font
                                            fontWeight:
                                                FontWeight.bold, // Bold text
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const VerticalDivider(color: Colors.white),
                                  // Divider between buttons
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        // Set the background color to red
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          // Handle the delete action here
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                          // Add your delete logic here
                                        },
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(
                                            color: Colors.white,
                                            // Change text color to white
                                            fontFamily: 'Montserrat',
                                            // Montserrat font
                                            fontWeight:
                                                FontWeight.bold, // Bold text
                                          ), // Change text color to white
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Delete Plan',
                      style: TextStyle(
                        color: Color(0xFFE4DCFF), //E4DCFF
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent, // Set background color to transparent
        border: Border.all(
          color: Colors.white, // Set border color to white
          width: 2.0, // Adjust the border width as needed
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        widget.letter,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18, // Set the font size to 16
        ),
      ),
    );
  }
}
