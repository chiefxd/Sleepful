// icon_with_text.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconWithText extends StatelessWidget {
  final IconData? icon; // Make icon optional
  final SvgPicture? customIcon; // New parameter for SVG icons
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final double size; // New size parameter

  const IconWithText({
    super.key,
    this.icon, // Make icon optional
    this.customIcon, // New parameter for SVG icons
    required this.text,
    required this.onPressed,
    this.color,
    this.size = 36, // Default size for icons
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkResponse(
          onTap: onPressed,
          child: customIcon != null // Check if customIcon is provided
              ? SizedBox(
            width: size, // Set width for SVG icon
            height: size, // Set height for SVG icon
            child: customIcon, // Use the SVG icon if provided
          )
              : Icon(
            icon,
            size: size, // Use the provided size for regular icons
            color: color,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2), // Reduce the distance between the icon and the text
          child: Text(
            text,
            style: TextStyle(fontSize: 13, color: color),
          ),
        ),
      ],
    );
  }
}