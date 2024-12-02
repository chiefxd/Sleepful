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

  Widget _buildEditableRow1({
    required String label,
    required String value,
    required TextEditingController controller,
    required bool isEditing,
    required VoidCallback onEdit,
  }) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  fontSize: screenWidth * 0.03,
                  color: Color(0xFFB4A9D6),
                ),
              ),
              Spacer(),
              if (!isEditing)
                IconButton(
                  icon: Icon(Icons.edit, color: Color(0xFFB4A9D6)),
                  onPressed: onEdit,
                ),
            ],
          ),
          if (isEditing)
            TextField(
              controller: controller,
              style: TextStyle(
                color: Color(0xFFB4A9D6),
                fontFamily: 'Montserrat',
                fontSize: screenWidth * 0.03,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Enter $label',
                hintStyle: TextStyle(fontSize: 12),
              ),
            )
          else
            Text(
              value,
              style: TextStyle(
                color: Color(0xFFB4A9D6),
                fontFamily: 'Montserrat',
                fontSize: screenWidth * 0.03,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEditableRow2({
    required String label,
    required String value,
    required TextEditingController controller,
    required bool isEditing,
    required VoidCallback onEdit,
  }) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  fontSize: screenWidth * 0.03,
                  color: Color(0xFFB4A9D6),
                ),
              ),
              SizedBox(height: 45),
            ],
          ),
          if (isEditing)
            TextField(
              controller: controller,
              style: TextStyle(
                color: Color(0xFFB4A9D6),
                fontFamily: 'Montserrat',
                fontSize: screenWidth * 0.03,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Enter $label',
                hintStyle: TextStyle(fontSize: 12),
              ),
            )
          else
            Text(
              value,
              style: TextStyle(
                color: Color(0xFFB4A9D6),
                fontFamily: 'Montserrat',
                fontSize: screenWidth * 0.03,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
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
          children: [
            SizedBox(height: 25),
            GestureDetector(
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
              child: CircleAvatar(
                radius: 75,
                backgroundImage: _controller.selectedImage != null
                    ? FileImage(_controller.selectedImage!)
                    : AssetImage('assets/images/Contoh 1.png') as ImageProvider,
              ),
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
            SizedBox(height: 20),
            _buildEditableRow1(
              label: 'Name',
              value: name,
              controller: _controller.nameController,
              isEditing: isEditingName,
              onEdit: () => setState(() => isEditingName = true),
            ),
            // Email Address Section (No Pencil Icon)
            _buildEditableRow2(
              label: 'Email Address',
              value: email,
              controller: _controller.emailController,
              isEditing: false, // Email is non-editable
              onEdit: () {}, // Empty callback to avoid showing the pencil icon
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
