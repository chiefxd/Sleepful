import 'package:flutter/material.dart';

class ChangeTheme extends StatelessWidget {
  const ChangeTheme({super.key});

 @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double titleFontSize = screenWidth * 0.06;
    // double subtitleFontSize = screenWidth * 0.04;

    return Scaffold(
      // Section 1: Title and Back Button
      body: NestedScrollView(
        headerSliverBuilder: (context, innerIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
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
                  'Change Theme',
                  style: TextStyle(
                    fontSize: titleFontSize,
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
        }, body: Center(),
      ),
    );
  }
}