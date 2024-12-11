import 'package:flutter/material.dart';

import '../../Pages/Sounds/sound_player.dart';
import '../../Pages/Sounds/sounds.dart';

class SoundsSection extends StatelessWidget {
  const SoundsSection({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(
          left: 20, right: 20), // Add padding of 20 pixels
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sounds',
                style: TextStyle(
                  fontSize: screenWidth * 0.07, // Set the font size to 28
                  fontWeight: FontWeight.bold, // Set the font weight to bold
                  fontFamily: 'Montserrat',
                  color: Color(0xFFE4DCFF), // Set the text color to 0xFFA594F9
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SoundPage()),
                  );
                },
                child: Text(
                  'More >',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color:
                        Color(0x8CE4DCFF), // Set the text color to 0xFFCDC1FF
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
              height: 20), // Add some space between the title and images
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // First Image
                _buildSoundItem(
                    context,
                    'Cloudy',
                    'assets/images/rain.jpg',
                    SoundPlayer(
                      soundTitle: 'Cloudy',
                    )),
                // Second Image
                _buildSoundItem(
                    context,
                    'Fireplace',
                    'assets/images/night.jpg',
                    SoundPlayer(
                      soundTitle: 'Fireplace',
                    )),
                // Third Image
                _buildSoundItem(
                    context,
                    'Sleep Mix',
                    'assets/images/mix.jpg',
                    SoundPlayer(
                      soundTitle: 'Sleep Mix',
                    )),
                // Fourth Image
                _buildSoundItem(
                    context,
                    'Frosty',
                    'assets/images/winter.jpg',
                    SoundPlayer(
                      soundTitle: 'Frosty',
                    )),
                // Fifth Image
                _buildSoundItem(
                    context,
                    'Midnight',
                    'assets/images/comfort.jpeg',
                    SoundPlayer(
                      soundTitle: 'Midnight',
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSoundItem(
      BuildContext context, String label, String imagePath, Widget nextPage) {
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 25), // Space between images
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath, // Replace with your image path
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 5), // Space between image and text
            Text(
              label,
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ), // Adjust text style as needed
            ),
          ],
        ),
      ),
    );
  }
}
