import 'package:flutter/material.dart';

class Information extends StatelessWidget {
  const Information({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Information',
          style: TextStyle(
            color: Colors.white, // Set the text color to white
          ),
        ),
      ),
    );
  }
}