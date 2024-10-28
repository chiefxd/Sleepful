import 'package:flutter/material.dart';

class SoundsSad extends StatelessWidget {
  const SoundsSad({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Sad',
          style: TextStyle(
            color: Colors.white, // Set the text color to white
          ),
        ),
      ),
    );
  }
}