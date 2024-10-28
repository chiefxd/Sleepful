import 'package:flutter/material.dart';

class SoundsMix extends StatelessWidget {
  const SoundsMix({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Mix',
          style: TextStyle(
            color: Colors.white, // Set the text color to white
          ),
        ),
      ),
    );
  }
}