import 'package:flutter/material.dart';

import '../../Pages/Information/info_squares.dart';

class Information extends StatelessWidget {
  const Information({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // Use Stack to position the PlusButton
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
                        'assets/images/buttonBack.png', // Use the same back button image
                        width: 48,
                        height: 48,
                      ),
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Text(
                      'Informations',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily:
                            'Montserrat', // Ensure the same font family is used
                        color: Theme.of(context)
                            .colorScheme
                            .primary, // Use the same color as in profile.dart
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
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                    child: InfoSquares(),
                  ),
                  // BottomNavbar(selectedIndex: -1),
                ],
              ),
            ),
          ),
          // Positioned(
          //   bottom: 56,
          //   left: MediaQuery.of(context).size.width / 2 - 27,
          //   child: const PlusButton(),
          // ),
        ],
      ),
    );
  }
}
