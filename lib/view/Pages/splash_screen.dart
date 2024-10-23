import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sleepful/view/Pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Stack(
        children: [
          Center(
              child: Image.asset(
            'assets/images/Logo Sleepful.png',
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width * 0.7,
          )),
          Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "assets/images/Awan.png",
                fit: BoxFit.fill,
              ))
        ],
      )),
    );
  }
}
