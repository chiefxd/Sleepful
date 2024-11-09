import 'package:flutter/material.dart';
import '../Navbar/bottom_navbar.dart';
import '../Components/plus_button.dart'; // Make sure to import your PlusButton widget

class SleepingStats extends StatelessWidget {
  final int selectedIndex; // Add selectedIndex parameter

  const SleepingStats({super.key, this.selectedIndex = 4});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: const Text(
              'Sleeping Stats',
              style: TextStyle(
                color: Colors.white, // Set the text color to white
              ),
            ),
          ),
          Positioned(
            bottom: 56, // Adjust this value as needed
            left: MediaQuery.of(context).size.width / 2 - 27,
            child: const PlusButton(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavbar(selectedIndex: selectedIndex),
          ),
        ],
      ),
    );
  }
}