import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../view/Pages/home_page.dart';

class SignInController {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  bool isPasswordVisible;

  SignInController({
    required this.emailController,
    required this.passwordController,
    this.isPasswordVisible = false,
  });

  // Function to show toast
  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  // Sign-in function
  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Navigate to the home page after successful sign-in
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast('Invalid e-mail or password');
      } else {
        showToast(e.message ?? 'Sign-in failed');
      }
    } catch (e) {
      showToast('An error occurred. Please try again.');
    }
  }

  // Validate inputs and call the sign-in function
  void validateAndSignIn(BuildContext context) {
    if (emailController.text.trim().isEmpty) {
      showToast('Please enter your email');
      return;
    }
    if (!emailController.text.trim().contains('@')) {
      showToast('Please enter a valid email');
      return;
    }
    if (passwordController.text.trim().isEmpty) {
      showToast('Please enter your password');
      return;
    }
    if (passwordController.text.trim().length < 6) {
      showToast('Password must be at least 6 characters');
      return;
    }

    signInWithEmailAndPassword(context);
  }
}
