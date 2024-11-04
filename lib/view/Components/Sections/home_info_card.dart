// home_info_card.dart
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onReadMore;
  final Color cardColor; // Background color of the card
  final Color titleColor; // Color of the title text
  final double titleFontSize;
  final double readMoreFontSize;

  const InfoCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onReadMore,
    this.cardColor = Colors.white, // Default card color
    this.titleColor = Colors.white, // Default title color
    this.titleFontSize = 14,
    this.readMoreFontSize= 12,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Remove fixed height to allow dynamic height adjustment
      width: 150, // Set a fixed width for the card
      child: Card(
        color: cardColor, // Set the card color here
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Allow the column to take minimum height
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: SizedBox(
                width: double.infinity, // Ensure the image takes the full width of the card
                height: 100, // Set a fixed height for the image
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: titleColor, // Set the title color here
                    ),
                    maxLines: 3, // Limit the title to a maximum of 3 lines
                    overflow: TextOverflow.ellipsis, // Add ellipsis if the text overflows
                  ),
                  const SizedBox(height: 8), // Add some space between the title and the button
                  SizedBox(
                    height: 24, // Set your desired height here
                    child: ElevatedButton(
                      onPressed: onReadMore,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6048A6), // Button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8), // Adjust horizontal padding
                        textStyle: TextStyle(
                          fontSize: readMoreFontSize, // Smaller font size
                        ),
                      ),
                      child: const Text(
                        'Read More',
                        style: TextStyle(
                          color: Colors.white,
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
    );
  }
}