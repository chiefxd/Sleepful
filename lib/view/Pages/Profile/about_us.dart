import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('About Us',
          style: TextStyle(
            color: Colors.white, // Set the text color to white
          ),
        ),
      ),
    );
  }
}