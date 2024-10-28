import 'package:flutter/material.dart';

class CardDetailExample extends StatelessWidget {
  const CardDetailExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Example Information',
          style: TextStyle(
            color: Colors.white, // Set the text color to white
          ),
        ),
      ),
    );
  }
}