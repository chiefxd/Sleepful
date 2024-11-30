import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sleepful/view/Pages/signin_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();

  bool _isPasswordVisible = false;

  // Show Toast
  void showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Sign up with Firebase
  Future<void> _signUpWithEmailAndPassword() async {
    try {
      if (_passwordController.text.trim() !=
          _confirmPasswordController.text.trim()) {
        showToast("Passwords do not match");
        return;
      }

      // Create user using Firebase Auth
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      showToast('Account created successfully');

      // Check if the widget is still mounted before calling Navigator
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignIn()),
        );
      }
    } on FirebaseAuthException catch (e) {
      showToast(e.message ?? 'Sign up failed');
    }
  }

  // Validate inputs and call the sign-up function
  void validateAndSignUp() {
    if (_emailController.text.trim().isEmpty) {
      showToast('Please enter your email');
      return;
    }
    if (!_emailController.text.trim().contains('@')) {
      showToast('Please enter a valid email');
      return;
    }
    if (_passwordController.text.trim().isEmpty) {
      showToast('Please enter your password');
      return;
    }
    if (_passwordController.text.trim().length < 6) {
      showToast('Password must be at least 6 characters');
      return;
    }
    if (_confirmPasswordController.text.trim().isEmpty) {
      showToast('Please confirm your password');
      return;
    }

    // If validation passes, proceed to sign up
    _signUpWithEmailAndPassword();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double buttonSize = screenWidth * 0.4;
    double titleFontSize = screenWidth * 0.06;
    double subtitleFontSize = screenWidth * 0.04;
    double buttonFontSize = screenWidth * 0.05;
    double smallTextFontSize = screenWidth * 0.03;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Image.asset(
                  'assets/images/Logo Sleepful.png',
                  fit: BoxFit.fill,
                  width: screenWidth * 0.4,
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
                  child: Text(
                    'Welcome to Sleepful!',
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
              ShaderMask(
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
                child: Text(
                  'Get ready to sleep peacefully',
                  style: TextStyle(
                    fontSize: subtitleFontSize,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Name input field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, bottom: 5),
                    child: Text(
                      'Name',
                      style: TextStyle(
                          fontSize: subtitleFontSize,
                          fontWeight: FontWeight.normal,
                          color: const Color(0xFFFFFFFF),
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB5B5B5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Enter your name',
                        hintStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: subtitleFontSize),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),

              // Email input field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, bottom: 5),
                    child: Text(
                      'E-mail',
                      style: TextStyle(
                          fontSize: subtitleFontSize,
                          fontWeight: FontWeight.normal,
                          color: const Color(0xFFFFFFFF),
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB5B5B5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter your e-mail',
                        hintStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: subtitleFontSize),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),

              // Password input field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, bottom: 5),
                    child: Text(
                      'Password',
                      style: TextStyle(
                          fontSize: subtitleFontSize,
                          fontWeight: FontWeight.normal,
                          color: const Color(0xFFFFFFFF),
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB5B5B5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: subtitleFontSize,
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10),
                        suffixIcon: IconButton(
                          padding: const EdgeInsets.only(left: 20),
                          constraints: const BoxConstraints(
                            maxHeight: 24,
                            maxWidth: 24,
                          ),
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),

              // Confirm Password input field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, bottom: 5),
                    child: Text(
                      'Confirm Password',
                      style: TextStyle(
                          fontSize: subtitleFontSize,
                          fontWeight: FontWeight.normal,
                          color: const Color(0xFFFFFFFF),
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB5B5B5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        hintText: 'Re-enter your password',
                        hintStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: subtitleFontSize,
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10),
                        suffixIcon: IconButton(
                          padding: const EdgeInsets.only(left: 20),
                          constraints: const BoxConstraints(
                            maxHeight: 24,
                            maxWidth: 24,
                          ),
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Center(
                  child: SizedBox(
                    width: buttonSize,
                    child: ElevatedButton(
                      onPressed: validateAndSignUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF725FAC),
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: buttonFontSize,
                        ),
                        minimumSize: const Size(double.infinity, 40),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text('Sign Up',
                          style: TextStyle(fontSize: buttonFontSize)),
                    ),
                  ),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignIn()),
                          );
                        },
                        child: Text(
                          'Already have an account? Sign In Here',
                          style: TextStyle(
                            fontSize: smallTextFontSize,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFB4A9D6),
                            fontFamily: 'Montserrat',
                            decoration: TextDecoration.underline,
                            decorationColor: const Color(0xFFB4A9D6),
                            decorationThickness: 1,
                          ),
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
    );
  }
}
