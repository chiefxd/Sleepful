// bottom_navbar.dart
import 'package:flutter/material.dart';
import '../Pages/home_page.dart';
import 'icon_with_text.dart';
import '../Pages/sleeping_stats.dart';
import '../Pages/settings.dart';
import '../Pages/calendar.dart';

const Color iconText = Color(0xFFFFFFFF); //2196F3
const Color navbarColor = Color(0xFFA594F9); //CDC1FF

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
        border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
        color: navbarColor,
      ),
      child: Row(
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
          // Removed the SizedBox and PlusButton from here
          IconWithText(
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
          IconWithText(
            icon: Icons.settings,
            text: 'Settings',
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
    );
  }
}