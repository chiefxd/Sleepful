import 'package:flutter/material.dart';
import '../../Pages/sounds.dart';
import '../../Pages/sounds_more.dart';
import '../../Pages/Sounds/sounds_sad.dart';
import '../../Pages/Sounds/sounds_night.dart';
import '../../Pages/Sounds/sounds_mix.dart';
import '../../Pages/Sounds/sounds_winter.dart';
import '../../Pages/Sounds/sounds_lofi.dart';

class SoundsSection extends StatelessWidget {
  const SoundsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20), // Add padding of 20 pixels
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Sounds',
                style: TextStyle(
                  fontSize: 28, // Set the font size to 16
                  fontWeight: FontWeight.bold, // Set the font weight to bold
                  fontFamily: 'Montserrat',
                  color: Color(0xFFE4DCFF), // Set the text color to 0xFFA594F9
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SoundPage()),
                  );
                },
                child: Text(
                  'More >',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: Color(0x8CE4DCFF), // Set the text color to 0xFFCDC1FF
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20), // Add some space between the title and images
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // First Image
                _buildSoundItem(context, 'Sad', 'assets/images/Contoh 1.png', SoundsSad()),
                // Second Image
                _buildSoundItem(context, 'Night', 'assets/images/Long.png', SoundsNight()),
                // Third Image
                _buildSoundItem(context, 'Mix', 'assets/images/Long.png', SoundsMix()),
                // Fourth Image
                _buildSoundItem(context, 'Winter', 'assets/images/Contoh 1.png', SoundsWinter()),
                // Fifth Image
                _buildSoundItem(context, 'Lofi', 'assets/images/Long.png', SoundsLofi()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSoundItem(BuildContext context, String label, String imagePath, Widget nextPage) {
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
              style: const TextStyle(
                fontSize: 16,
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