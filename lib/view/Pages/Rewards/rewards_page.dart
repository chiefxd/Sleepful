import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleepful/providers/user_data_provider.dart';
import 'package:sleepful/view/Pages/home_page.dart';

import '../../Components/plus_button.dart';
import '../../Navbar/bottom_navbar.dart';
import 'rewards_card.dart';

class RewardsPage extends StatelessWidget {
  final int selectedIndex;

  const RewardsPage({super.key, this.selectedIndex = 2});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double subtitleFontSize =
        screenWidth * 0.04; // 4% of screen width for subtitles
    double largeTextFontSize =
        screenWidth * 0.16; // 16% of screen width for large text
    double smallTextFontSize = screenWidth * 0.04;

    final userData = Provider.of<UserDataProvider>(context);

    // Call fetchAndSetUserData after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      print('Calling fetchAndSetUserData with userId: $userId');
      Provider.of<UserDataProvider>(context, listen: false)
          .fetchAndSetUserData(userId);
    });

    List<String> imagePaths = [
      'assets/images/Contoh 1.png',
      'assets/images/Contoh 2.png',
      'assets/images/Contoh 3.png',
      'assets/images/Contoh 1.png',
      'assets/images/Long.png',
    ];

    // Unique ID for each card
    List<String> soundId = [
      'reward_sound_1',
      'reward_sound_2',
      'reward_sound_3',
      'reward_sound_4',
      'reward_sound_5',
    ];

    // Unique titles for each card
    List<String> titles = [
      'Title A',
      'Title B',
      'Title C',
      'Title D',
      'Title E',
    ];

    // Unique minutes for each card
    List<String> minutes = [
      '2m',
      '6m',
      '4m',
      '8m',
      '10m',
    ];

    List<int> points = [
      5,
      10,
      15,
      20,
      25,
    ];

    return Scaffold(
      body: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder: (context, innerIsScrolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomePage())); // Go back to the previous screen
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
                    child: Text(
                      'Rewards',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Theme.of(context).colorScheme.primary,
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        // Section 2: You've earned text
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'You have',
                                style: TextStyle(
                                  fontSize: smallTextFontSize,
                                  color: Theme.of(context).colorScheme.primary,
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
                                    stops: [0, 0.28, 1],
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
                                  '${userData.points} Points',
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
                                      text: 'Collect more points by',
                                      style: TextStyle(
                                        fontSize: subtitleFontSize,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' completing your plans',
                                      style: TextStyle(
                                        fontSize: subtitleFontSize,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '1 point will be awarded every 24 hours',
                                style: TextStyle(
                                  fontSize: subtitleFontSize,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Add some space before the next text
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                    top: 20), // Add padding of 20 pixels
                                child: Align(
                                  alignment:
                                      Alignment.centerLeft, // Align to the left
                                  child: Text(
                                    'Sounds',
                                    style: TextStyle(
                                      fontSize: screenWidth *
                                          0.07, // Set the font size to 28
                                      fontWeight: FontWeight
                                          .bold, // Set the font weight to bold
                                      fontFamily: 'Montserrat',
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary, // Set the text color to 0xFFA594F9
                                    ),
                                  ),
                                ),
                              ),
                              // Grid of cards
                              GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.74,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      left: index % 2 == 0
                                          ? 20.0
                                          : 0.0, // Add left padding for left column cards
                                      right: index % 2 == 1
                                          ? 20.0
                                          : 0.0, // Add right padding for right column cards
                                    ),
                                    child: RewardsCard(
                                      title: titles[index], // Dynamic title
                                      minutes:
                                          minutes[index], // Dynamic minutes
                                      imagePath: imagePaths[index],
                                      soundId: soundId[
                                          index], // Replace with your image path
                                      points: points[index],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
                BottomNavbar(selectedIndex: selectedIndex),
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
}
