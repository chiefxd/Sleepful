// main.dart
import 'package:flutter/material.dart';
import 'Pages/home_page.dart'; // Import the HomePage widget

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF120C23),//0xFF120C23 // Set the default scaffold background color to black
      ),

      home: const HomePage(), // Use the HomePage widget
    );
  }
}