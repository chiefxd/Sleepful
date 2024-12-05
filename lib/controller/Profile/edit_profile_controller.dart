import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditProfileController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  File? selectedImage;

  String name = "Loading...";
  String email = "Loading...";

  // Load profile data from Firestore
  Future<void> loadProfileData() async {
    final userDoc =
        FirebaseFirestore.instance.collection('Users').doc('USER_ID');
    final snapshot = await userDoc.get();

    if (snapshot.exists) {
      name = snapshot['name'];
      email = snapshot['email'];

      nameController.text = name;
      emailController.text = email;
    }
  }

  // Save updated name to Firestore
  Future<void> saveNameToFirestore() async {
    final userDoc =
        FirebaseFirestore.instance.collection('Users').doc('USER_ID');
    await userDoc.update({'name': nameController.text});
    name = nameController.text;
  }
}
