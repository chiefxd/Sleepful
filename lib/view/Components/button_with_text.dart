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
    double buttonSize = MediaQuery.of(context).size.width * 0.20; // Adjust this value as needed
    double iconSize = buttonSize * 0.8; // Make the icon size a percentage of the button size
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            // Remove minimumSize to allow button to resize based on its child
            // foregroundColor is set to white by default, you can keep it or remove it
            minimumSize: Size(buttonSize, buttonSize),
            foregroundColor: Colors.white,
            backgroundColor: buttonColor,
            padding: EdgeInsets.all(0), // Add padding for better touch area
          ),
          child: Icon(
            icon,
            // size: MediaQuery.of(context).size.width * 0.10,
            size: iconSize,
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
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat-Bold',
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }
}