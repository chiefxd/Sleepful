// import 'dart:math';

import 'package:flutter/material.dart';
import 'rewards_redeem.dart';

class RewardsCard extends StatelessWidget {
  final String title;
  final String minutes;
  final String imagePath;

  // final VoidCallback unlockPoints;
  final int points;

  const RewardsCard({
    super.key,
    required this.title,
    required this.minutes,
    required this.imagePath,
    // required this.unlockPoints,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10), bottom: Radius.circular(10)),
              image: DecorationImage(
                image: AssetImage(imagePath),
                // Image path passed from RewardsPage
                fit: BoxFit.cover, // Cover the entire area
              ),
            ),
            height: 140, // Set a fixed height for the image
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              color: Color(0xFFE4DCFF),
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          ),
          Text(
            minutes,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFFE4DCFF),
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 24, // Set your desired height for the button
            child: ElevatedButton(
              onPressed: () {
                // Navigate to RewardsRedeem and pass the imagePath
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RewardsRedeem(
                      imagePath: imagePath,
                      title: title,
                      minutes: minutes,
                      points: points,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFAB9FD1),
                // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                // Adjust horizontal padding
                textStyle: TextStyle(
                  fontSize: 14, // Smaller font size
                ),
              ),
              child: Text(
                'Unlock for $points pts',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
