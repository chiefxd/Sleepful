import 'package:flutter/material.dart';
import 'dart:io';

class EditProfileController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  File? selectedImage;

  void saveProfileData() {
    if (nameController.text.isEmpty || emailController.text.isEmpty) {
      // Show an error message to the user (e.g., using a snackbar)
      print("Name and Email cannot be empty"); // Replace with your error handling
      return;
    }

    String name = nameController.text;
    String email = emailController.text;

    // Perform save operation using the name, email, and selectedImage values
    // ... (e.g., send data to an API or database)

    // Example: Print the data for now
    print('Name: $name');
    print('Email: $email');
    print('Image Path: ${selectedImage?.path}');
  }
}