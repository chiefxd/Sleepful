// home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'view_plans.dart'; // Import the new_page_a.dart file
import 'sleeping_stats.dart'; // Import the page_b.dart file
import 'information.dart'; // Import the page_d.dart file
import '../Navbar/bottom_navbar.dart'; // Import the BottomNavbar widget
import '../Components/button_with_text.dart'; // Import the ButtonWithText widget
import '../Components/plus_button.dart'; // Import the PlusButton widget
import 'profile.dart';
import '../Components/Sections/home_sounds.dart';
import '../Components/Sections/home_info_card.dart';
import 'Information/example_detail_information.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Section 1: Hello You and Profile Icon
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  stops: [0, 0.28, 1],
                                  colors: [
                                    Color(0xFF6048A6),
                                    Color(0xFF8F7FC2),
                                    Color(0xFFB4A9D6), //B4A9D6
                                  ],
                                ).createShader(bounds);
                              },
                              blendMode: BlendMode.srcIn, //
                              child: const Text(
                                'Hello Stefan!',
                                style: TextStyle(
                                  fontSize: 24, // Set the font size to 16
                                  fontWeight: FontWeight.bold, // Set the font weight to bold// Set the text color to white
                                  fontFamily: 'Montserrat-Bold',
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Profile()),
                                );
                              },
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF6048A6),
                                  border: Border.all(color: Color(0xFF6048A6), width: 2),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20), // Add some space between sections

                      // Section 2: You've slept for text
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center, //gangaruh
                          children: [
                            const Text(
                              'You\'ve slept for',
                              style: TextStyle(
                                fontSize: 16, // Set the font size to 16
                                // fontWeight: FontWeight.bold, // Set the font weight to bold
                                color: Color(0xFFAB9FD1), // Set the text color to black
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  stops: [0, 0.28, 1],
                                  colors: [
                                    Color(0xFF6048A6),
                                    Color(0xFF8F7FC2),
                                    Color(0xFFB4A9D6), //B4A9D6
                                  ],
                                ).createShader(bounds);
                              },
                              blendMode: BlendMode.srcIn, // Add this line
                              child: const Text(
                                '7,5 Hours',
                                style: TextStyle(
                                  fontSize: 64,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',

                                ),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Your goal is: ',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color(0xFF8C7EB4), // Set the text color to 0xFF8C7EB4
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                  TextSpan(
                                    text: '8 Hours',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Color(0xFFE4DCFF), // Set the text color to 0xFFAB9FD1
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ' per day',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color(0xFFE4DCFF), // Set the text color to 0xFF8C7EB4
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Positioned(
                      //   bottom: 0,
                      //   left: 0,
                      //   right: 0,
                      //   child: CustomPaint(
                      //      painter: CloudPainter(),
                      //     child: Container(
                      //       height: 50, // Set the height of the cloud shape
                      //     ),
                      //   ),
                      // ),
                      //   ],
                      // ),
                      const SizedBox(height: 50), // Add some space between sections
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Use spaceBetween to evenly distribute the buttons
                              children: [
                                const SizedBox(
                                  width: 120, // Set a fixed width for each button
                                  child: ButtonWithText(
                                    icon: Icons.calendar_month,
                                    text: 'View\nPlans',
                                    nextPage: ViewPlans(),
                                    // buttonColor: Color(0xFFCDC1FF),
                                    textColor: Color(0xFFE4DCFF),
                                  ),
                                ),
                                const SizedBox(
                                  width: 120, // Set a fixed width for each button
                                  child: ButtonWithText(
                                    icon: Icons.bar_chart,
                                    text: 'Sleeping\nStats',
                                    nextPage: SleepingStats(),
                                    // buttonColor: Color(0xFFCDC1FF),
                                    textColor: Color(0xFFE4DCFF),
                                  ),
                                ),
                                SizedBox(
                                  width: 120, // Set a fixed width for each button
                                  child: ButtonWithText(
                                    customIcon: SizedBox(
                                      height: 50, // Set a fixed height
                                      width: 50, // Set a fixed width if necessary
                                      child: SvgPicture.asset('assets/icons/breathing-icon.svg', fit: BoxFit.contain), // Use fit to control how the SVG is rendered
                                    ),
                                    text: 'Breathing\nExercise',
                                    // buttonColor: const Color(0xFFCDC1FF),
                                    textColor: const Color(0xFFE4DCFF), //0xFFCDC1FF
                                    nextPage: const Information(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30), // Add some space before the new section
                      const SoundsSection(),
                      const SizedBox(height: 10), // Add some space after the new section// Add some space between sections
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Information',
                                  style: TextStyle(
                                    fontSize: 28, // Set the font size to 16
                                    fontWeight: FontWeight.bold, // Set the font weight to bold
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFFE4DCFF), // Set the text color to 0xFFA594F9
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const Information()),
                                    );
                                  },
                                  child: Text(
                                    'More >',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                      color: Color(0x8CE4DCFF), // Set the text color to 0xFFCDC1FF
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20), // Add some space between rows
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const CardDetailExample()),
                                      );
                                    },
                                    child: InfoCard(
                                      title: 'This is a sample text yes yes yes',
                                      imagePath: 'assets/images/Long.png',
                                      onReadMore: () {}, // Remove this callback
                                      cardColor: const Color(0xFF1F1249),
                                      titleColor: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const CardDetailExample()),
                                      );
                                    },
                                    child: InfoCard(
                                      title: 'This is another sample text',
                                      imagePath: 'assets/images/Contoh 1.png',
                                      onReadMore: () {}, // Remove this callback
                                      cardColor: const Color(0xFF1F1249),
                                      titleColor: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const CardDetailExample()),
                                      );
                                    },
                                    child: InfoCard(
                                      title: 'This is a sample text',
                                      imagePath: 'assets/images/Long.png',
                                      onReadMore: () {}, // Remove this callback
                                      cardColor: const Color(0xFF1F1249),
                                      titleColor: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const CardDetailExample()),
                                      );
                                    },
                                    child: InfoCard(
                                      title: 'This is another sample text',
                                      imagePath: 'assets/images/Contoh 1.png',
                                      onReadMore: () {}, // Remove this callback
                                      cardColor: const Color(0xFF1F1249),
                                      titleColor: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const CardDetailExample()),
                                      );
                                    },
                                    child: InfoCard(
                                      title: 'This is a sample text',
                                      imagePath: 'assets/images/Long.png',
                                      onReadMore: () {}, // Remove this callback
                                      cardColor: const Color(0xFF1F1249),
                                      titleColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const BottomNavbar(),
            ],
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