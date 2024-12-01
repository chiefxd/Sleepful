import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sleepful/view/Pages/signin_page.dart';

class SignupController {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController nameController;
  final BuildContext context;

  SignupController({
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.nameController,
    required this.context,
  });

  bool _isPasswordVisible = false;

  // Show Toast
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

  // Sign up with Firebase
  Future<void> signUpWithEmailAndPassword() async {
    try {
      if (passwordController.text.trim() !=
          confirmPasswordController.text.trim()) {
        showToast("Passwords do not match");
        return;
      }

      // Create user using Firebase Auth
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // After user is created, add their data to Firestore
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.uid)
          .set({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'createdAt': Timestamp.now(),
      });

      showToast('Account created successfully');

      // Sign out the user immediately after account creation
      await FirebaseAuth.instance.signOut();

      // Navigate to the SignIn page, clearing the stack
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SignIn()),
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      showToast(e.message ?? 'Sign up failed');
    }
  }

  // Validate inputs and call the sign-up function
  void validateAndSignUp() {
    if (nameController.text.trim().isEmpty) {
      showToast('Please enter your name');
      return;
    }
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
    if (confirmPasswordController.text.trim().isEmpty) {
      showToast('Please confirm your password');
      return;
    }

    // If validation passes, proceed to sign up
    signUpWithEmailAndPassword();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
  }

  bool get isPasswordVisible => _isPasswordVisible;
}
