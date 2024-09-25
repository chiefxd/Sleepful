// home_page.dart
import 'package:flutter/material.dart';
import 'view_plans.dart'; // Import the new_page_a.dart file
import 'sleeping_stats.dart'; // Import the page_b.dart file
import 'settings.dart'; // Import the page_c.dart file
import 'information.dart'; // Import the page_d.dart file

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(100, 100), // Make the button a square
                  ),
                  child: const Icon(Icons.ac_unit), // Replace with your logo
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ViewPlans()),
                    );
                  },
                ),
                const SizedBox(width: 20), // Add some space between buttons
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(100, 100), // Make the button a square
                  ),
                  child: const Icon(Icons.access_alarm), // Replace with your logo
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SleepingStats()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20), // Add some space between rows
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(100, 100), // Make the button a square
                  ),
                  child: const Icon(Icons.add), // Replace with your logo
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Settings()),
                    );
                  },
                ),
                const SizedBox(width: 20), // Add some space between buttons
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(100, 100), // Make the button a square
                  ),
                  child: const Icon(Icons.airplanemode_active), // Replace with your logo
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Information()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}