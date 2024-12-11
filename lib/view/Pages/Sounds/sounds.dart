import 'package:flutter/material.dart';
import 'package:sleepful/view/Pages/Sounds/sound_squares.dart';

class SoundPage extends StatelessWidget {
  const SoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // Use Stack to position the PlusButton
        child: NestedScrollView(
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
                  child: const Text(
                    'Sounds',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily:
                          'Montserrat', // Ensure the same font family is used
                      color: Color(
                          0xFFB4A9D6), // Use the same color as in profile.dart
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
                  child: SoundSquares(),
                ),
                // BottomNavbar(selectedIndex: -1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
