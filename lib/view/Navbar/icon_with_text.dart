// icon_with_text.dart
import 'package:flutter/material.dart';

class IconWithText extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final Color? color;

  const IconWithText({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkResponse(
          onTap: onPressed,
          child: Icon(
            icon,
            size: 48, // Make the icon bigger
            color: color,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2), // Reduce the distance between the icon and the text
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: color),
          ),
        ),
      ],
    );
  }
}