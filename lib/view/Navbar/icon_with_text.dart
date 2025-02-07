// icon_with_text.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconWithText extends StatelessWidget {
  final IconData? icon;
  final SvgPicture? customIcon;
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final double size;

  const IconWithText({
    super.key,
    this.icon,
    this.customIcon,
    required this.text,
    required this.onPressed,
    this.color,
    this.size = 36,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkResponse(
          onTap: onPressed,
          child: customIcon != null
              ? SizedBox(
            width: size,
            height: size,
            child: customIcon,
          )
              : Icon(
            icon,
            size: size,
            color: color,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            text,
            style: TextStyle(fontSize: 13, color: color),
          ),
        ),
      ],
    );
  }
}