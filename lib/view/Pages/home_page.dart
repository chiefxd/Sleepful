import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sleepful/providers/user_data_provider.dart';
import 'package:sleepful/view/Pages/Breathing%20Exercise/breathing_exercise.dart';
import 'package:sleepful/view/Pages/Information/information_2.dart';
import 'package:sleepful/view/Pages/Information/information_3.dart';
import 'package:sleepful/view/Pages/Information/information_4.dart';
import 'package:sleepful/view/Pages/Information/information_5.dart';

import '../Components/Sections/home_info_card.dart';
import '../Components/Sections/home_sounds.dart';
import '../Components/button_with_text.dart';
import '../Components/plus_button.dart';
import '../Navbar/bottom_navbar.dart';
import 'Information/information.dart';
import 'Information/information_1.dart';
import 'Plans/view_plans.dart';
import 'Profile/profile.dart';
import 'Sleeping Stats/sleeping_stats.dart';

class HomePage extends StatefulWidget {
  final int selectedIndex; // Add selectedIndex parameter

  const HomePage({super.key, this.selectedIndex = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = '';
  final UserDataProvider _userDataProvider = UserDataProvider();

  @override
  void initState() {
    super.initState();
    // Listen for authentication state changes
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        _fetchUserData();
      }
    });
  }

  Future<void> _fetchUserData() async {
    await _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        userName = await _userDataProvider.getUserName(user.uid);
        setState(() {}); // Update the UI with the new name
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user name: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Define button size as a percentage of the screen width
    double buttonSize = screenWidth * 0.25; // Adjust this value as needed

    double titleFontSize = screenWidth * 0.06; // 6% of screen width for title
    double subtitleFontSize =
        screenWidth * 0.04; // 4% of screen width for subtitles
    double largeTextFontSize =
        screenWidth * 0.16; // 10% of screen width for large text
    double smallTextFontSize =
        screenWidth * 0.035; // 4% of screen width for small text
    double titleFontCardSize =
        screenWidth * 0.035; // Responsive font size for card title
    double readMoreFontSize = screenWidth * 0.030;

    return Scaffold(
      // Section 1: Hello You and Profile Icon
      body: SafeArea(
        child: NestedScrollView(
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
                          final bool isDarkMode =
                              Theme.of(context).brightness == Brightness.dark;
                          final Color baseColor = isDarkMode
                              ? Color(0xFFB4A9D6)
                              : Color(0xFF37256C);
                          return LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: const [0, 0.28, 1],
                            colors: [
                              Color.lerp(baseColor, Colors.white,
                                  0.2)!, // Lighten the color
                              baseColor, // Base color
                              Color.lerp(baseColor, Colors.black,
                                  0.2)!, // Darken the color
                            ],
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.srcIn,
                        child: Text(
                          'Hello $userName!',
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
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
                          color: Theme.of(context).colorScheme.error,
                          border:
                              Border.all(width: 2, color: Colors.transparent),
                        ),
                        child: Center(
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
                centerTitle: false,
                floating: false,
                snap: false,
                pinned: false,
                forceElevated: innerIsScrolled,
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
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                                ShaderMask(
                                  shaderCallback: (Rect bounds) {
                                    final bool isDarkMode =
                                        Theme.of(context).brightness ==
                                            Brightness.dark;
                                    final Color baseColor = isDarkMode
                                        ? Color(0xFFB4A9D6)
                                        : Color(0xFF37256C);
                                    return LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      stops: const [0, 0.28, 1],
                                      colors: [
                                        Color.lerp(baseColor, Colors.white,
                                            0.0)!, // Lighten the color
                                        baseColor, // Base color
                                        Color.lerp(baseColor, Colors.black,
                                            0.0)!, // Darken the color
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
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.color,
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                      TextSpan(
                                        text: '8 Hours',
                                        style: TextStyle(
                                          fontSize: subtitleFontSize,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.color,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' per day',
                                        style: TextStyle(
                                          fontSize: subtitleFontSize,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.color,
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
                                          textColor: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.color,
                                          buttonColor: Colors.transparent),
                                    ),
                                    SizedBox(
                                      width: buttonSize,
                                      child: ButtonWithText(
                                        icon: Icons.bar_chart,
                                        text: 'Sleeping\nStats',
                                        nextPage: SleepingStats(
                                          selectedIndex: 3,
                                        ),
                                        textColor: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.color,
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
                                        nextPage: const BreathingExercise(),
                                        textColor: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.color,
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
                                      'Informations',
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.07,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.color,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Information()),
                                        );
                                      },
                                      child: Text(
                                        'More >',
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.04,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat',
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.color,
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
                                                    const InformationOne()),
                                          );
                                        },
                                        child: InfoCard(
                                          title:
                                              'Kesehatan Mental Dapat Terpengaruhi oleh Tidur?',
                                          imagePath: 'assets/images/info 1.jpg',
                                          onReadMore:
                                              () {}, // Remove this callback
                                          cardColor: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          titleColor: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
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
                                                    const InformationTwo()),
                                          );
                                        },
                                        child: InfoCard(
                                          title:
                                              'Apakah Benar Kurang Tidur Mempengaruhi Penampilan? Ini Jawabannya!',
                                          imagePath: 'assets/images/info 2.jpg',
                                          onReadMore:
                                              () {}, // Remove this callback
                                          cardColor: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          titleColor: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
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
                                                    const InformationThree()),
                                          );
                                        },
                                        child: InfoCard(
                                          title:
                                              'Begini Caranya Mencegah Tidur saat Belajar!',
                                          imagePath: 'assets/images/info 3.jpg',
                                          onReadMore:
                                              () {}, // Remove this callback
                                          cardColor: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          titleColor: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
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
                                                    const InformationFour()),
                                          );
                                        },
                                        child: InfoCard(
                                          title:
                                              'Capek, tapi Tidak Bisa Tidur? Ini Alasannya!',
                                          imagePath: 'assets/images/info 4.jpg',
                                          onReadMore:
                                              () {}, // Remove this callback
                                          cardColor: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          titleColor: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
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
                                                    const InformationFive()),
                                          );
                                        },
                                        child: InfoCard(
                                          title:
                                              'Ini Beberapa Tips & Trik Agar Cepat Tidur!',
                                          imagePath: 'assets/images/info 5.jpg',
                                          onReadMore:
                                              () {}, // Remove this callback
                                          cardColor: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          titleColor: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
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
                  BottomNavbar(selectedIndex: widget.selectedIndex),
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
      ),
    );
  }
}
