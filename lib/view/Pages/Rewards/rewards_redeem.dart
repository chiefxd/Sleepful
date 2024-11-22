import 'package:flutter/material.dart';
import '../sounds.dart';

class RewardsRedeem extends StatelessWidget {
  final String imagePath; // Add imagePath parameter
  final String title;
  final String minutes;
  final int points;
  final int selectedIndex;

  const RewardsRedeem(
      {super.key,
      required this.imagePath,
        required this.title,
        required this.minutes,
        required this.points,
      this.selectedIndex = 2}); // Initialize imagePath

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double subtitleFontSize =
        screenWidth * 0.04; // 4% of screen width for subtitles
    double largeTextFontSize = screenWidth * 0.06; // Adjusted for title
    double smallTextFontSize = screenWidth * 0.035;
    double bottomText = screenWidth * 0.05;

    return Scaffold(
      body: Stack(
        children: [
          // Use SafeArea to avoid overlapping with the status bar
          SafeArea(
            child: Column(
              children: [
                // Display the image at the top
                Container(
                  height: screenHeight * 0.4, // Set height for the image
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imagePath), // Use the passed imagePath
                      fit: BoxFit.cover, // Cover the entire area
                    ),
                  ),
                ),
                // Title, Subtitle, and Paragraph
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: largeTextFontSize,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              color: Color(0xFFE4DCFF),
                            ),
                          ),
                          Text(
                            minutes, // New string on the right
                            style: TextStyle(
                              fontSize: smallTextFontSize,
                              fontFamily: 'Montserrat',
                              color: Color(0xFFE4DCFF),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 8.0),
                      // Space between title and subtitle
                      Text(
                        'Your Subtitle Here',
                        style: TextStyle(
                          fontSize: subtitleFontSize,
                          fontFamily: 'Montserrat',
                          color: Color(0xFFE4DCFF),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      // Space between subtitle and paragraph
                      Text(
                        'This is a paragraph text that provides more information about the reward that has been redeemed. You can add more details here to inform the user about the next steps or any other relevant information.',
                        style: TextStyle(
                          fontSize: smallTextFontSize,
                          fontFamily: 'Montserrat',
                          color: Color(0xFFE4DCFF),
                        ),
                      ),
                    ],
                  ),
                ),
                // Spacer to push the rectangle to the bottom
                Spacer(),
                // Rectangle at the bottom
                Container(
                  padding: EdgeInsets.all(16.0),
                  margin: EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF1F1249),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '$points PTS',
                        style: TextStyle(
                          color: Color(0xFFE4DCFF),
                          fontSize: bottomText,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      SizedBox(width: 24.0), // Space between text and button
                      Expanded(
                        // Wrap the button in an Expanded widget
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SoundPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFE4DCFF), // Background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0), // Rounded corners
                            ),
                          ),
                          child: Text(
                            'Redeem',
                            style: TextStyle(
                              color: Color(0xFF120C23),
                              fontSize: bottomText,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Back button on top of the image
          Positioned(
            top: 27,
            left: 4,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(); // Go back to the previous screen
                },
                child: Image.asset(
                  'assets/images/buttonBack.png',
                  width: 48,
                  height: 48,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
