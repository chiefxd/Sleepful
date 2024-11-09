// main.dart
import 'package:flutter/material.dart';
import 'package:sleepful/view/Pages/Profile/about_us.dart';
import 'package:sleepful/view/Pages/Profile/change_password.dart';
import 'package:sleepful/view/Pages/Profile/change_theme.dart';
import 'package:sleepful/view/Pages/Profile/edit_profile.dart';
import 'package:sleepful/view/Pages/Profile/logout.dart';
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

      routes: {
        '/editProfile': (context) => EditProfile(),
        '/change_password': (context) => ChangePassword(),
        '/change_theme': (context) => ChangeTheme(),
        '/about_us': (context) => AboutUs(),
        '/logout': (context) => Logout(),
      },

      home: const SplashScreen(), // Use the HomePage widget
    );
  }
}