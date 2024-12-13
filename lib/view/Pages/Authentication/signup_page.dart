import 'package:flutter/material.dart';
import 'package:sleepful/controller/Authentication/signup_controller.dart';
import 'package:sleepful/view/Pages/Authentication/signin_page.dart'; // Import the controller

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

  late SignupController _signupController;

  @override
  void initState() {
    super.initState();
    _signupController = SignupController(
      emailController: _emailController,
      passwordController: _passwordController,
      confirmPasswordController: _confirmPasswordController,
      nameController: _nameController,
      context: context,
    );
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
                    final bool isDarkMode =
                        Theme.of(context).brightness == Brightness.dark;
                    final Color baseColor =
                        isDarkMode ? Color(0xFFB4A9D6) : Color(0xFF37256C);
                    return LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [0, 0.28, 1],
                      colors: [
                        Color.lerp(
                            baseColor, Colors.white, 0.0)!, // Lighten the color
                        baseColor, // Base color
                        Color.lerp(
                            baseColor, Colors.black, 0.0)!, // Darken the color
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
                  final bool isDarkMode =
                      Theme.of(context).brightness == Brightness.dark;
                  final Color baseColor =
                      isDarkMode ? Color(0xFFB4A9D6) : Color(0xFF37256C);
                  return LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0, 0.28, 1],
                    colors: [
                      Color.lerp(
                          baseColor, Colors.white, 0.0)!, // Lighten the color
                      baseColor, // Base color
                      Color.lerp(
                          baseColor, Colors.black, 0.0)!, // Darken the color
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
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter your name',
                        hintStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: subtitleFontSize,
                            color: Colors.grey[800]),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),

              // Email input field
              _buildInputField(
                label: 'E-mail',
                controller: _emailController,
                hintText: 'Enter your e-mail',
                subtitleFontSize: subtitleFontSize,
              ),

              // Password input field
              _buildPasswordField(
                controller: _passwordController,
                subtitleFontSize: subtitleFontSize,
                label: 'Password',
                hintText: 'Enter your password',
              ),

              // Confirm Password input field
              _buildPasswordField(
                controller: _confirmPasswordController,
                subtitleFontSize: subtitleFontSize,
                label: 'Confirm Password',
                hintText: 'Re-enter your password',
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Center(
                  child: SizedBox(
                    width: buttonSize,
                    child: ElevatedButton(
                      onPressed: _signupController.validateAndSignUp,
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

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required double subtitleFontSize,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, bottom: 5),
          child: Text(
            label,
            style: TextStyle(
                fontSize: subtitleFontSize,
                fontWeight: FontWeight.normal,
                color: const Color(0xFFFFFFFF),
                fontFamily: 'Montserrat'),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            color: const Color(0xFFB5B5B5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: subtitleFontSize,
                  color: Colors.grey[800]),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required double subtitleFontSize,
    required String label,
    required String hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, bottom: 5),
          child: Text(
            label,
            style: TextStyle(
                fontSize: subtitleFontSize,
                fontWeight: FontWeight.normal,
                color: const Color(0xFFFFFFFF),
                fontFamily: 'Montserrat'),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            color: const Color(0xFFB5B5B5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: !_signupController.isPasswordVisible,
             style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: subtitleFontSize,
                color: Colors.grey[800],
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              suffixIcon: IconButton(
                padding: const EdgeInsets.only(left: 20),
                constraints: const BoxConstraints(maxHeight: 24, maxWidth: 24),
                icon: Icon(
                  _signupController.isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _signupController.togglePasswordVisibility();
                  });
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
