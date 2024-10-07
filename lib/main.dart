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
    return const MaterialApp(
      title: 'My App',
      home: HomePage(), // Use the HomePage widget
    );
  }
}