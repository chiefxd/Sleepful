import 'package:flutter/material.dart';

class SoundsNight extends StatelessWidget {
  const SoundsNight({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Night',
          style: TextStyle(
            color: Colors.white, // Set the text color to white
          ),
        ),
      ),
    );
  }
}