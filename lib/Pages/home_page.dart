// home_page.dart
import 'package:flutter/material.dart';
import 'view_plans.dart'; // Import the new_page_a.dart file
import 'sleeping_stats.dart'; // Import the page_b.dart file
import 'settings.dart'; // Import the page_c.dart file
import 'information.dart'; // Import the page_d.dart file
import '../Navbar/bottom_navbar.dart'; // Import the BottomNavbar widget
import '../Components/button_with_text.dart'; // Import the ButtonWithText widget

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 200, // Set the height of the rectangle
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text('Youve slept for 7,5 hours'),
                    ),
                  ),
                  const SizedBox(height: 20), // Add some space between sections
                  const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline, // Add this line
                          textBaseline: TextBaseline.alphabetic, // Add this line
                          children: [
                            SizedBox(
                              width: 150, // Set a fixed width for each button
                              child: ButtonWithText(
                                icon: Icons.calendar_month,
                                text: 'View Plans',
                                nextPage: ViewPlans(),
                                buttonColor: Color(0xFFCDC1FF),
                                textColor: Color(0xFFCDC1FF),
                              ),
                            ),
                            SizedBox(width: 10), // Add some space between buttons
                            SizedBox(
                              width: 150, // Set a fixed width for each button
                              child: ButtonWithText(
                                icon: Icons.bar_chart,
                                text: 'Sleeping Stats',
                                nextPage: SleepingStats(),
                                buttonColor: Color(0xFFCDC1FF),
                                textColor: Color(0xFFCDC1FF),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20), // Add some space between rows
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline, // Add this line
                          textBaseline: TextBaseline.alphabetic, // Add this line
                          children: [
                            SizedBox(
                              width: 150, // Set a fixed width for each button
                              child: ButtonWithText(
                                icon: Icons.article,
                                text: 'Information',
                                // textColor: Color.fromRGBO(33, 150, 243, 1.0),
                                buttonColor: Color(0xFFCDC1FF),
                                textColor: Color(0xFFCDC1FF),
                                nextPage: Information(),
                              ),
                            ),
                            SizedBox(width: 10), // Add some space between buttons
                            SizedBox(
                              width: 150, // Set a fixed width for each button
                              child: ButtonWithText(
                                icon: Icons.settings,
                                text: 'Settings',
                                nextPage: Settings(),
                                buttonColor: Color(0xFFCDC1FF),
                                textColor: Color(0xFFCDC1FF),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20), // Add some space between sections
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Section Title'),
                            Text('Section Subtitle'),
                          ],
                        ),
                        const SizedBox(height: 20), // Add some space between rows
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: Image.asset('assets/images/Long.png', fit: BoxFit.cover),
                                    ),
                                    const SizedBox(width: 10),
                                    const Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'This is a sample text',
                                            style: TextStyle(fontSize: 12), // Set the font size to 12
                                          ),
                                          Text(
                                            'This is another sample text',
                                            style: TextStyle(fontSize: 12), // Set the font size to 12
                                          ),
                                          Text(
                                            'This is yet another sample text',
                                            style: TextStyle(fontSize: 12), // Set the font size to 12
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                height: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: Image.asset('assets/images/Contoh 1.png', fit: BoxFit.cover),
                                    ),
                                    // Image.asset('assets/images/Test1.png', fit: BoxFit.cover),
                                    const SizedBox(width: 10),
                                    const Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'This is a sample text',
                                            style: TextStyle(fontSize: 12), // Set the font size to 12
                                          ),
                                          Text(
                                            'This is another sample text',
                                            style: TextStyle(fontSize: 12), // Set the font size to 12
                                          ),
                                          Text(
                                            'This is yet another sample text',
                                            style: TextStyle(fontSize: 12), // Set the font size to 12
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const BottomNavbar(), // Add the BottomNavbar widget
        ],
      ),
    );
  }
}