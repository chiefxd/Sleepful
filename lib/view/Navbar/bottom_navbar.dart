// bottom_navbar.dart
import 'package:flutter/material.dart';
import '../Pages/home_page.dart';
import 'icon_with_text.dart';
import '../Pages/sleeping_stats.dart';
import '../Pages/settings.dart';
import '../Pages/calendar.dart';

const Color iconText = Color(0xFFFFFFFF); //2196F3
const Color navbarColor = Color(0xFF1F1249); //CDC1FF , 1F1249 , 0xFFA594F9

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  BottomNavbarState createState() => BottomNavbarState();
}

class BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80, // adjust the height as needed
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: navbarColor, width: 0.5)),
        color: navbarColor,
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconWithText(
                icon: Icons.home,
                text: 'Home',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                color: iconText,
              ),
              IconWithText(
                icon: Icons.calendar_month,
                text: 'Calendar',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Calendar()),
                  );
                },
                color: iconText,
              ),
              // Placeholder for "My Stats" to maintain layout
              SizedBox(width: 60), // Adjust width as needed
              IconWithText(
                icon: Icons.settings,
                text: 'Rewards',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Settings()),
                  );
                },
                color: iconText,
              ),
            ],
          ),
          // Positioned for "My Stats"
          Positioned(
            left: MediaQuery.of(context).size.width / 1.6 - 20, // Adjust as needed
            top: 0,
            bottom: 0,
            child: Center(
              child: IconWithText(
                icon: Icons.bar_chart,
                text: 'My Stats',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SleepingStats()),
                  );
                },
                color: iconText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}