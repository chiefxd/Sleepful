import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sleepful/controller/Profile/edit_profile_controller.dart';
import 'package:sleepful/providers/user_data_provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _controller = EditProfileController();
  final UserDataProvider _userDataProvider = UserDataProvider();
  bool isEditingName = false;

  String name = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        name = await _userDataProvider.getFullName(user.uid);
        email = user.email ?? ''; // Directly use FirebaseAuth for email
        setState(() {
          _controller.nameController.text = name;
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

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

  Future<void> _saveToFirestore() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await _userDataProvider.updateUserData(
          user.uid,
          {'name': _controller.nameController.text},
        );
        setState(() {
          name = _controller.nameController.text;
          isEditingName = false;
        });

        // Use your custom showToast method to show success message
        showToast('Profile updated successfully');
      }
    } catch (e) {
      print("Error saving to Firestore: $e");

      // Use your custom showToast method to show error message
      showToast('Error updating profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonFontSize = screenWidth * 0.05;
    double buttonSize = screenWidth * 0.3;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              'assets/images/buttonBack.png',
              width: 48,
              height: 48,
            ),
          ),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: screenWidth * 0.06,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            color: Color(0xFFB4A9D6),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 25),
            // Profile Picture and Text Section
            GestureDetector(
              // Wrap both the CircleAvatar and Text in GestureDetector
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);

                if (image != null) {
                  setState(() {
                    _controller.selectedImage = File(image.path);
                  });
                }
              },
              child: Column(
                // Use a Column to arrange the CircleAvatar and Text
                children: [
                  CircleAvatar(
                    radius: 75,
                    backgroundImage: _controller.selectedImage != null
                        ? FileImage(_controller.selectedImage!)
                        : AssetImage('assets/images/Contoh 1.png')
                            as ImageProvider,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Change Profile Picture',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: Color(0xFFB4A9D6),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Text(
                    'Name:',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: Color(0xFFB4A9D6),
                    ),
                  ),
                  SizedBox(width: 10),
                  // Editable name field
                  Expanded(
                    child: isEditingName
                        ? TextField(
                            controller: _controller.nameController,
                            style: TextStyle(
                              // Style applied to the TextField's text
                              fontSize: screenWidth * 0.04,
                              fontFamily: 'Montserrat',
                              color: Color(0xFFB4A9D6),
                            ),
                            decoration: InputDecoration(
                              hintText: 'Enter your name',
                              hintStyle: TextStyle(
                                fontSize: screenWidth * 0.04,
                                fontFamily: 'Montserrat',
                                color: isEditingName
                                    ? Color(0xFFD9CAB3)
                                    : Color(0xFFB4A9D6),
                              ),
                            ),
                          )
                        : Text(
                            name,
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              fontFamily: 'Montserrat',
                              color: Color(0xFFB4A9D6),
                            ),
                          ),
                  ),
                  // Edit button (removed check icon)
                  if (!isEditingName) // Show only when not editing
                    IconButton(
                      icon: Icon(Icons.edit, color: Color(0xFFB4A9D6)),
                      onPressed: () {
                        setState(() {
                          isEditingName = !isEditingName;
                        });
                      },
                    ),
                ],
              ),
            ),

            SizedBox(height: 10),
            // Email
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Text(
                    'Email:',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: Color(0xFFB4A9D6),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    email, // Display the fetched email
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontFamily: 'Montserrat',
                      color: Color(0xFFB4A9D6),
                    ),
                  ),
                ],
              ),
            ),

            // Save Button (visible only when editing)
            if (isEditingName)
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: SizedBox(
                  width: buttonSize,
                  child: ElevatedButton(
                    onPressed: _saveToFirestore,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF725FAC),
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: buttonFontSize,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('Save'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
