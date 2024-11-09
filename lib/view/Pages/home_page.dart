// home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Plans/view_plans.dart'; // Import the new_page_a.dart file
import 'sleeping_stats.dart'; // Import the page_b.dart file
import 'information.dart'; // Import the page_d.dart file
import '../Navbar/bottom_navbar.dart'; // Import the BottomNavbar widget
import '../Components/button_with_text.dart'; // Import the ButtonWithText widget
import '../Components/plus_button.dart'; // Import the PlusButton widget
import 'Profile/profile.dart';
import '../Components/Sections/home_sounds.dart';
import '../Components/Sections/home_info_card.dart';
import 'Information/example_detail_information.dart';

class HomePage extends StatelessWidget {
  final int selectedIndex; // Add selectedIndex parameter

  const HomePage({super.key, this.selectedIndex = 0});

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Define button size as a percentage of the screen width
    double buttonSize = screenWidth * 0.25; // Adjust this value as needed

    double titleFontSize = screenWidth * 0.06; // 6% of screen width for title
    double subtitleFontSize = screenWidth * 0.04; // 4% of screen width for subtitles
    double largeTextFontSize = screenWidth * 0.16; // 10% of screen width for large text
    double smallTextFontSize = screenWidth * 0.04; // 4% of screen width for small text
    double titleFontCardSize = screenWidth * 0.035; // Responsive font size for card title
    double readMoreFontSize = screenWidth * 0.030;

    return Scaffold(
      // Section 1: Hello You and Profile Icon
      body: NestedScrollView(
        headerSliverBuilder: (context, innerIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Row(
                children: [
                  Expanded(
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0, 0.28, 1],
                          colors: [
                            Color(0xFF6048A6),
                            Color(0xFF8F7FC2),
                            Color(0xFFB4A9D6),
                          ],
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.srcIn,
                      child: Text(
                        'Hello Stefan!',
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat-Bold',
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Profile()),
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
              floating: true, // Make AppBar reappear quickly
              snap: true, // Snap AppBar into place
              pinned: false, // Keep AppBar visible at the top
            ),
          ];
        },
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        // Section 2: You've slept for text
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'You\'ve slept for',
                                style: TextStyle(
                                  fontSize: smallTextFontSize,
                                  color: Color(0xFFB4A9D6),
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
                                      Color(0xFFB4A9D6),
                                    ],
                                  ).createShader(bounds);
                                },
                                blendMode: BlendMode.srcIn,
                                child: Text(
                                  '7,5 Hours',
                                  style: TextStyle(
                                    fontSize: largeTextFontSize,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Your goal is: ',
                                      style: TextStyle(
                                        fontSize: subtitleFontSize,
                                        color: Color(0xFFB4A9D6),
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                    TextSpan(
                                      text: '8 Hours',
                                      style: TextStyle(
                                        fontSize: subtitleFontSize,
                                        color: Color(0xFFB4A9D6),
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' per day',
                                      style: TextStyle(
                                        fontSize: subtitleFontSize,
                                        color: Color(0xFFB4A9D6),
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 50),

                        // Section 3: View Plans and Sleeping Stats
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: buttonSize,
                                    child: ButtonWithText(
                                      icon: Icons.calendar_month,
                                      text: 'View\nPlans',
                                      nextPage: ViewPlans(),
                                      textColor: Color(0xFFE4DCFF),
                                    ),
                                  ),
                                  SizedBox(
                                    width: buttonSize,
                                    child: ButtonWithText(
                                      icon: Icons.bar_chart,
                                      text: 'Sleeping\nStats',
                                      nextPage: SleepingStats(),
                                      textColor: Color(0xFFE4DCFF),
                                    ),
                                  ),
                                  SizedBox(
                                    width: buttonSize,
                                    child: ButtonWithText(
                                      customIcon: SizedBox(
                                        height: buttonSize * 0.5,
                                        width: buttonSize * 0.5,
                                        child: SvgPicture.asset(
                                            'assets/icons/breathing-icon.svg',
                                            fit: BoxFit.contain),
                                      ),
                                      text: 'Breathing\nExercise',
                                      nextPage: const Information(),
                                      textColor: Color(0xFFE4DCFF),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Section 4: Home Sounds
                        const SoundsSection(),
                        const SizedBox(height: 10),

                        // Section 5: Information Cards
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Information',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.07,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFFE4DCFF),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Information()),
                                      );
                                    },
                                    child: Text(
                                      'More >',
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.04,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                        color: Color(0x8CE4DCFF),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CardDetailExample()),
                                        );
                                      },
                                      child: InfoCard(
                                        title:
                                            'This is a sample text yes yes yes',
                                        imagePath: 'assets/images/Long.png',
                                        onReadMore:
                                            () {}, // Remove this callback
                                        cardColor: const Color(0xFF1F1249),
                                        titleColor: Colors.white,
                                        titleFontSize: titleFontCardSize,
                                        readMoreFontSize: readMoreFontSize,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CardDetailExample()),
                                        );
                                      },
                                      child: InfoCard(
                                        title: 'This is another sample text',
                                        imagePath: 'assets/images/Contoh 1.png',
                                        onReadMore:
                                            () {}, // Remove this callback
                                        cardColor: const Color(0xFF1F1249),
                                        titleColor: Colors.white,
                                        titleFontSize: titleFontCardSize,
                                        readMoreFontSize: readMoreFontSize,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CardDetailExample()),
                                        );
                                      },
                                      child: InfoCard(
                                        title: 'This is a sample text',
                                        imagePath: 'assets/images/Long.png',
                                        onReadMore:
                                            () {}, // Remove this callback
                                        cardColor: const Color(0xFF1F1249),
                                        titleColor: Colors.white,
                                        titleFontSize: titleFontCardSize,
                                        readMoreFontSize: readMoreFontSize,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CardDetailExample()),
                                        );
                                      },
                                      child: InfoCard(
                                        title: 'This is another sample text ',
                                        imagePath: 'assets/images/Contoh 1.png',
                                        onReadMore:
                                            () {}, // Remove this callback
                                        cardColor: const Color(0xFF1F1249),
                                        titleColor: Colors.white,
                                        titleFontSize: titleFontCardSize,
                                        readMoreFontSize: readMoreFontSize,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CardDetailExample()),
                                        );
                                      },
                                      child: InfoCard(
                                        title: 'This is a sample text',
                                        imagePath: 'assets/images/Long.png',
                                        onReadMore:
                                            () {}, // Remove this callback
                                        cardColor: const Color(0xFF1F1249),
                                        titleColor: Colors.white,
                                        titleFontSize: titleFontCardSize,
                                        readMoreFontSize: readMoreFontSize,
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
                BottomNavbar(selectedIndex: selectedIndex),
              ],
            ),
            Positioned(
              bottom: 56,
              left: MediaQuery.of(context).size.width / 2 - 27,
              child: const PlusButton(),
            ),
          ],
        ),
      ),
    );
  }
}
