import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sleepful/view/Pages/home_page.dart'; // Import the HomePage
import 'package:sleepful/view/Pages/Authentication/signin_page.dart'; // Import the SignIn page

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  User? _user;

  @override
  void initState() {
    super.initState();
    // Listen to FirebaseAuth state changes
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _user = user; // Update the user state
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // While FirebaseAuth is loading or checking authentication state
    if (_user == null) {
      // If no user is signed in, navigate to the SignIn screen
      return const SignIn();
    } else {
      // If the user is signed in, navigate to the HomePage
      return const HomePage();
    }
  }
}
