// main.dart
import 'package:flutter/material.dart';
import 'package:sleepful/view/Pages/splash_screen.dart';
// Import the HomePage widget

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sleepful',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF120C23),//0xFF120C23 // Set the default scaffold background color to black
      ),

      home: const SplashScreen(), // Use the HomePage widget
    );
  }
}