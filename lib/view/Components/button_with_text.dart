// button_with_text.dart
import 'package:flutter/material.dart';

class ButtonWithText extends StatelessWidget {
  final IconData? icon; // Make this nullable
  final Widget? customIcon; // New parameter for custom icons
  final String text;
  final Widget nextPage;
  final Color? textColor;
  final Color? buttonColor;
  final Color? borderColor; // New parameter for border color

  const ButtonWithText({
    super.key,
    this.icon, // Keep this for standard icons
    this.customIcon, // New parameter for custom icons
    required this.text,
    required this.nextPage,
    this.textColor,
    this.buttonColor,
    this.borderColor, // Accept border color
  });

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Define button size as a percentage of the screen width
    double buttonSize = screenWidth * 0.20; // Adjust this value as needed

    double iconSize = buttonSize * 0.6; // Make the icon size a percentage of the button size
    double buttonTextSize = screenWidth * 0.04;

    // Define the gradient
    final Gradient gradient = LinearGradient(
      colors: [
        const Color(0xFF493190),
        const Color(0xFF725FAC),
        const Color(0xFF8472BB),
      ],
      stops: const [0.0, 0.5, 1.0],
    );

    return Column(
      children: [
        Container(
          width: buttonSize,
          height: buttonSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: buttonColor,
          ),
          child: CustomPaint(
            painter: GradientBorderPainter(gradient),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: Size(buttonSize, buttonSize),
                foregroundColor: Colors.white,
                backgroundColor: Colors.transparent,
                // Make the button background transparent
                padding: EdgeInsets.all(0),
              ),
              child: customIcon ?? Icon(
                icon,
                size: iconSize,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => nextPage),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
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
              fontSize:  buttonTextSize,
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

class GradientBorderPainter extends CustomPainter {
  final Gradient gradient;

  GradientBorderPainter(this.gradient);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4; // Adjust the border width as needed

    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(20)),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}