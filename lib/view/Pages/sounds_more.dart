import 'package:flutter/material.dart';

class SoundsMore extends StatelessWidget {
  const SoundsMore({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Sounds More',
          style: TextStyle(
            color: Colors.white, // Set the text color to white
          ),
        ),
      ),
    );
  }
}