import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sleepful/controller/Authentication/change_password_controller.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<ChangePassword> {
  final _controller = ChangePasswordController();
  final _auth = FirebaseAuth.instance;

  Widget _buildEditableIconRow(IconData icon, String text, double fontSize,
      TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Icon(icon, color: Color(0xFFB4A9D6)),
                SizedBox(width: 10),
                Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: Color(0xFFB4A9D6),
                  ),
                ),
              ],
            ),
          ),
          TextField(
            controller: controller,
            obscureText: true,
            style: TextStyle(
                color: Color(0xFFB4A9D6),
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Enter $text',
              hintStyle: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double titleFontSize = screenWidth * 0.06;
    double subtitleFontSize = screenWidth * 0.04;
    double buttonFontSize = screenWidth * 0.05;
    double buttonSize = screenWidth * 0.3;

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

    return Scaffold(
      // Section 1: Title and Back Button
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
        title: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Text(
            'Change Password',
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              color: Color(0xFFB4A9D6),
            ),
          ),
        ),
      ),

      // Section 2: Change Password Contents
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 25),

                // Password Text Field
                Column(
                  children: [
                    _buildEditableIconRow(
                      Icons.password_rounded,
                      'Old Password',
                      subtitleFontSize,
                      _controller
                          .oldPassController, // Use the controller from the separate class
                    ),
                    _buildEditableIconRow(
                      Icons.password_rounded,
                      'New Password',
                      subtitleFontSize,
                      _controller
                          .newPassController, // Use the controller from the separate class
                    ),
                    _buildEditableIconRow(
                      Icons.password_rounded,
                      'Confirm New Password',
                      subtitleFontSize,
                      _controller
                          .confirmNewPassController, // Use the controller from the separate class
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Center(
                    child: SizedBox(
                      width: buttonSize,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            // 1. Reauthenticate the user
                            final user = _auth.currentUser;
                            if (user != null) {
                              final credential = EmailAuthProvider.credential(
                                email: user.email!,
                                password: _controller.oldPassController.text,
                              );
                              await user
                                  .reauthenticateWithCredential(credential);

                              // 2. Update the password
                              await user.updatePassword(
                                  _controller.newPassController.text);

                              // 3. Show success message and navigate back using Fluttertoast
                              showToast(
                                  'Password changed successfully!'); // Call your showToast function
                              Navigator.pop(context);
                            }
                          } on FirebaseAuthException catch (e) {
                            // Handle errors using Fluttertoast
                            String errorMessage = 'An error occurred';
                            if (e.code == 'wrong-password') {
                              errorMessage = 'Incorrect old password';
                            } else if (e.code == 'weak-password') {
                              errorMessage = 'New password is too weak';
                            }
                            showToast(errorMessage); // Call your showToast function
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF725FAC),
                          foregroundColor: Colors.white,
                          textStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: buttonFontSize),
                          minimumSize: const Size(double.infinity, 40),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text('Save',
                            style: TextStyle(fontSize: buttonFontSize)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
