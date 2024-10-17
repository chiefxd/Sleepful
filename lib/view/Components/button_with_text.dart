// button_with_text.dart
import 'package:flutter/material.dart';

class ButtonWithText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Widget nextPage;
  final Color? textColor;
  final Color? buttonColor;

  const ButtonWithText({
    super.key,
    required this.icon,
    required this.text,
    required this.nextPage,
    this.textColor,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: const Size(100, 100), //button kotak
            foregroundColor: Colors.white,
            backgroundColor: buttonColor,
          ),
          child: Icon(
            icon,
            size: MediaQuery.of(context).size.width * 0.14, // Size icon responsip
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => nextPage),
            );
          },
        ),
        const SizedBox(height: 10), // Add a distance between the button and the text
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => nextPage),
            );
          },
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }
}