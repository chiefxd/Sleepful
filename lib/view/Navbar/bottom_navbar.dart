import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Pages/Calendar/calendar.dart';
import '../Pages/Rewards/rewards_page.dart';
import '../Pages/Sleeping Stats/sleeping_stats.dart';
import '../Pages/home_page.dart';
import 'icon_with_text.dart';

final user = FirebaseAuth.instance.currentUser ;
final userId = user?.uid;

class BottomNavbar extends StatefulWidget {
  final int selectedIndex;

  const BottomNavbar({super.key, required this.selectedIndex});

  @override
  BottomNavbarState createState() => BottomNavbarState();
}

class BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    Color iconText = Theme.of(context).colorScheme.tertiary;
    Color navbarColor = Theme.of(context).colorScheme.onPrimary;

    bool isOnMainPage = widget.selectedIndex >= 0 && widget.selectedIndex <= 3;

    return Container(
      height: 80,
      decoration: BoxDecoration(
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
                    MaterialPageRoute(
                        builder: (context) => const HomePage(selectedIndex: 0)),
                  );
                },
                color: isOnMainPage && widget.selectedIndex == 0
                    ? iconText
                    : const Color(0xFF7F779A),
              ),
              IconWithText(
                icon: Icons.calendar_month,
                text: 'Calendar',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Calendar(userId: userId ?? '')),
                  );
                },
                color: isOnMainPage && widget.selectedIndex == 1
                    ? iconText
                    : const Color(0xFF7F779A),
              ),
              SizedBox(width: 60),
              IconWithText(
                icon: Icons.star,
                text: 'Rewards',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const RewardsPage(selectedIndex: 2)),
                  );
                },
                color: isOnMainPage && widget.selectedIndex == 2
                    ? iconText
                    : const Color(
                        0xFF7F779A),
              ),
            ],
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 1.6 -
                20,
            top: 0,
            bottom: 0,
            child: Center(
              child: IconWithText(
                icon: Icons.bar_chart,
                text: 'My Stats',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const SleepingStats(selectedIndex: 3)),
                  );
                },
                color: isOnMainPage && widget.selectedIndex == 3
                    ? iconText
                    : const Color(0xFF7F779A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
