import 'package:flutter/material.dart';
import '../Navbar/bottom_navbar.dart';
import '../Components/plus_button.dart'; // Make sure to import your PlusButton widget

class Calendar extends StatelessWidget {
  final int selectedIndex; // Add selectedIndex parameter

  const Calendar({super.key, this.selectedIndex = 1});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: const Text(
              'Calendar',
              style: TextStyle(
                color: Colors.white, // Set the text color to white
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavbar(selectedIndex: selectedIndex),
          ),
          Positioned(
            bottom: 56, // Adjust this value as needed
            left: MediaQuery.of(context).size.width / 2 - 27,
            child: const PlusButton(),
          ),

        ],
      ),
    );
  }
}