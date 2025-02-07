// home_info_card.dart
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onReadMore;
  final Color cardColor;
  final Color titleColor;
  final double titleFontSize;
  final double readMoreFontSize;

  const InfoCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onReadMore,
    this.cardColor = Colors.white,
    this.titleColor = Colors.white,
    this.titleFontSize = 14,
    this.readMoreFontSize= 12,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Card(
        color: cardColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: SizedBox(
                width: double.infinity,
                height: 100,
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
                      color: titleColor,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 24,
                    child: ElevatedButton(
                      onPressed: onReadMore,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6048A6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        textStyle: TextStyle(
                          fontSize: readMoreFontSize,
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