import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sleepful/providers/user_data_provider.dart';
import 'package:sleepful/view/Pages/Breathing%20Exercise/breathing_exercise.dart';
import 'package:sleepful/view/Pages/Information/information_2.dart';
import 'package:sleepful/view/Pages/Information/information_3.dart';
import 'package:sleepful/view/Pages/Information/information_4.dart';
import 'package:sleepful/view/Pages/Information/information_5.dart';
import 'package:sleepful/view/Pages/Plans/add_plans.dart';

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

  // Fetch yesterday's sleep data
  Future<double> _fetchYesterdaySleepData() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      return 0.0;
    }

    final yesterday = DateTime.now().subtract(Duration(days: 1));
    final startOfYesterday =
        DateTime(yesterday.year, yesterday.month, yesterday.day);
    final endOfYesterday =
        DateTime(yesterday.year, yesterday.month, yesterday.day, 23, 59, 59);

    final snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Successful Plans')
        .where('successfulDate', isGreaterThanOrEqualTo: startOfYesterday)
        .where('successfulDate', isLessThanOrEqualTo: endOfYesterday)
        .get();

    double totalSleepTime = 0.0;
    for (var doc in snapshot.docs) {
      final data = doc.data();
      final startTime = data['startTime'] as String;
      final endTime = data['endTime'] as String;

      final startDateTime = _parseTime(yesterday, startTime);
      final endDateTime = _parseTime(yesterday, endTime);
      final duration = endDateTime.difference(startDateTime).inMinutes / 60.0;

      totalSleepTime += duration;
    }

    return totalSleepTime;
  }

  // Parse time
  DateTime _parseTime(DateTime date, String time) {
    int hour = int.parse(time.split(':')[0]);
    int minute = int.parse(time.split(':')[1].split(' ')[0]);
    if (time.contains('PM') && hour != 12) hour += 12;
    if (time.contains('AM') && hour == 12) hour = 0;
    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  @override
  void initState() {
    super.initState();
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
        setState(() {}); // Update new name
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user name: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double buttonSize = screenWidth * 0.25;

    double titleFontSize = screenWidth * 0.06;
    double subtitleFontSize =
        screenWidth * 0.04;
    double largeTextFontSize =
        screenWidth * 0.16;
    double smallTextFontSize =
        screenWidth * 0.035;
    double titleFontCardSize =
        screenWidth * 0.035;
    double readMoreFontSize = screenWidth * 0.030;

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
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
                                  FutureBuilder<double>(
                                    future: _fetchYesterdaySleepData(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      }
                                      if (snapshot.hasError) {
                                        return Text("Error fetching data");
                                      }

                                      final yesterdaySleepTime =
                                          snapshot.data ?? 0.0;
                                      final message =
                                          (yesterdaySleepTime >= 7.0)
                                              ? "You slept enough, Good job!"
                                              : "You need more sleep today!";

                                      return Column(
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
                                                  Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark;
                                              final Color baseColor = isDarkMode
                                                  ? Color(0xFFB4A9D6)
                                                  : Color(0xFF37256C);
                                              return LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                stops: const [0, 0.28, 1],
                                                colors: [
                                                  Color.lerp(
                                                      baseColor,
                                                      Colors.white,
                                                      0.0)!, // Lighten the color
                                                  baseColor, // Base color
                                                  Color.lerp(
                                                      baseColor,
                                                      Colors.black,
                                                      0.0)!, // Darken the color
                                                ],
                                              ).createShader(bounds);
                                            },
                                            blendMode: BlendMode.srcIn,
                                            child: Text(
                                              '${yesterdaySleepTime.toStringAsFixed(1)} Hours',
                                              style: TextStyle(
                                                fontSize: largeTextFontSize,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Montserrat',
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            message,
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
                                      );
                                    },
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
                                            text: 'My\nPlans',
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
                                          text: 'My\nStats',
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
                                        'Information',
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
                                            imagePath:
                                                'assets/images/info 1.jpg',
                                            onReadMore:
                                                () {},
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
                                            imagePath:
                                                'assets/images/info 2.jpg',
                                            onReadMore:
                                                () {},
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
                                            imagePath:
                                                'assets/images/info 3.jpg',
                                            onReadMore:
                                                () {},
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
                                            imagePath:
                                                'assets/images/info 4.jpg',
                                            onReadMore:
                                                () {},
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
                                            imagePath:
                                                'assets/images/info 5.jpg',
                                            onReadMore:
                                                () {},
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
                  child: const PlusButton(
                    targetPage: AddPlans(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
