import 'package:flutter/material.dart';

import '../../Navbar/bottom_navbar.dart';
import '../../Components/plus_button.dart';

class ViewPlans extends StatelessWidget {
  const ViewPlans({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( // Use Stack to position the PlusButton
        children: [
          NestedScrollView(
            headerSliverBuilder: (context, innerIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(); // Go back to the previous screen
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        'assets/images/buttonBack.png', // Use the same back button image
                        width: 48,
                        height: 48,
                      ),
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: const Text(
                      'Your Plans',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat', // Ensure the same font family is used
                        color: Color(0xFFB4A9D6), // Use the same color as in profile.dart
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
            body: Column(
              children: [
                // List of Plans
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      _buildPlanCard('Plan Title 1', '2:00 AM - 11:00 AM'),
                      _buildPlanCard('Plan Title 2', '3:00 AM - 12:00 PM'),
                      _buildPlanCard('Plan Title 3', '4:00 AM - 1:00 PM'),
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

  Widget _buildPlanCard(String title, String timePeriod) {
    return Card(
      color: Color(0xFF1F1249),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0), // Padding for the entire card
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
            const SizedBox(height: 8.0), // Add some space before the days section
            // Days of the Week Section
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF6149A7),
                borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
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
                  const Text(
                    'Update Plan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 1, // Width of the line
                    height: 24, // Height of the line
                    color: Colors.white, // Color of the line
                  ),
                  const Text(
                    'Delete Plan',
                    style: TextStyle(
                      color: Color(0xFFE4DCFF), //E4DCFF
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
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