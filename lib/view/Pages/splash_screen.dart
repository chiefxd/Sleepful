import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sleepful/services/auth_check.dart'; // Import the AuthCheck page

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Wait for 3 seconds and navigate to AuthCheck (not SignIn directly)
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        // Check if the widget is still in the widget tree
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const AuthCheck()), // Navigate to AuthCheck
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/images/Logo Sleepful.png',
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width * 0.7,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              "assets/images/Awan.png",
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
