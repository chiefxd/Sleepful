import 'package:flutter/material.dart';

class ChangeTheme extends StatelessWidget {
  const ChangeTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Change Theme',
          style: TextStyle(
            color: Colors.white, // Set the text color to white
          ),
        ),
      ),
    );
  }
}