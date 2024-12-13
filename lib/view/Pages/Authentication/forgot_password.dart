import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  final TextEditingController _emailController = TextEditingController();

  // Handle Password Reset
  Future<void> sendPasswordResetEmail(BuildContext context) async {
    // Show Toast
    void showToast(String message) {
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }

    String email = _emailController.text.trim();
    if (email.isEmpty) {
      showToast("Please enter your email.");
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showToast("Password reset email sent. Check your inbox.");
      Navigator.pop(context); // Go back to the Sign In page
    } on FirebaseAuthException catch (e) {
      showToast(e.message ?? "Failed to send password reset email.");
    }
  }

  @override
  Widget build(BuildContext context) {
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
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Image.asset(
                      'assets/images/Logo Sleepful.png',
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0, 0.28, 1],
                          colors: [
                            Color(0xFFB4A9D6),
                            Color(0xFFB4A9D6),
                            Color(0xFFB4A9D6),
                          ],
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.srcIn,
                      child: const Text(
                        'Enter your e-mail',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      final bool isDarkMode =
                          Theme.of(context).brightness == Brightness.dark;
                      final Color baseColor =
                          isDarkMode ? Color(0xFFB4A9D6) : Color(0xFF37256C);
                      return LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [0, 0.28, 1],
                        colors: [
                          Color.lerp(baseColor, Colors.white,
                              0.0)!, // Lighten the color
                          baseColor, // Base color
                          Color.lerp(baseColor, Colors.black,
                              0.0)!, // Darken the color
                        ],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcIn,
                    child: const Text(
                      'to reset your password',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 30, bottom: 5),
                        child: Text(
                          'E-mail',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFFFFFFFF),
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 3),
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                          color: Color(0xFFB5B5B5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: _emailController,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter your e-mail',
                            hintStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.grey[800],
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Center(
                          child: SizedBox(
                            width: 150,
                            child: ElevatedButton(
                              onPressed: () => sendPasswordResetEmail(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF725FAC),
                                foregroundColor: Colors.white,
                                textStyle: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                                minimumSize: const Size(double.infinity, 40),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text('Send'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
