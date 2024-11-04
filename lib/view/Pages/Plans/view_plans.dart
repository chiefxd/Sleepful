import 'package:flutter/material.dart';

class ViewPlans extends StatelessWidget {
  const ViewPlans({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('View Plans',
          style: TextStyle(
            color: Colors.white, // Set the text color to white
          ),
        ),
      ),
    );
  }
}