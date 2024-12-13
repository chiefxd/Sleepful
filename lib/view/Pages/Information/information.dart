import 'package:flutter/material.dart';

import '../../Pages/Information/info_squares.dart';
import '../home_page.dart';

class Information extends StatelessWidget {
  const Information({super.key});

  @override
  Widget build(BuildContext context) {
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
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
                  title: Text(
                    'Informations',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  centerTitle: false,
                  floating: false,
                  snap: false,
                  pinned:
                      false, // This will keep the SliverAppBar visible and avoid space
                  forceElevated: innerIsScrolled,
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0), // Remove top padding
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
        ],
      ),
    );
  }
}
