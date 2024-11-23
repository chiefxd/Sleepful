import 'package:flutter/material.dart';
import '../../Navbar/bottom_navbar.dart';
import '../../Components/plus_button.dart';
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

    List<String> imagePaths = [
      'assets/images/Contoh 1.png',
      'assets/images/Contoh 2.png',
      'assets/images/Contoh 3.png',
      'assets/images/Contoh 1.png',
      'assets/images/Long.png',
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
                        width: 48,
                        height: 48,
                      ),
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: const Text(
                      'Rewards',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Color(0xFFB4A9D6),
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        // Section 2: You've slept for text
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'You have',
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
                                  '10 Points',
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
                                        color: Color(0xFFB4A9D6),
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'completing your plans',
                                      style: TextStyle(
                                        fontSize: subtitleFontSize,
                                        color: Color(0xFFB4A9D6),
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Add some space before the next text
                              Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20, top: 20), // Add padding of 20 pixels
                                child: Align(
                                  alignment: Alignment.centerLeft, // Align to the left
                                  child: Text(
                                    'Sounds',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.07, // Set the font size to 28
                                      fontWeight: FontWeight.bold, // Set the font weight to bold
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFFE4DCFF), // Set the text color to 0xFFA594F9
                                    ),
                                  ),
                                ),
                              ),
                              // Grid of cards
                              GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.74,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      left: index % 2 == 0 ? 20.0 : 0.0, // Add left padding for left column cards
                                      right: index % 2 == 1 ? 20.0 : 0.0, // Add right padding for right column cards
                                    ),
                                    child: RewardsCard(
                                      title: titles[index], // Dynamic title
                                      minutes: minutes[index], // Dynamic minutes
                                      imagePath: imagePaths[index], // Replace with your image path
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