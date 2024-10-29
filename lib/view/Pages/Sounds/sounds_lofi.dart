import 'package:flutter/material.dart';

class SoundsLofi extends StatelessWidget {
  const SoundsLofi({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Lofi',
          style: TextStyle(
            color: Colors.white, // Set the text color to white
          ),
        ),
      ),
    );
  }
}