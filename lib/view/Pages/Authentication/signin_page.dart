import 'package:flutter/material.dart';
import 'package:sleepful/controller/Authentication/signin_controller.dart';
import 'package:sleepful/view/Pages/Authentication/forgot_password.dart';
import 'package:sleepful/view/Pages/Authentication/signup_page.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late SignInController _signInController;

  @override
  void initState() {
    super.initState();
    _signInController = SignInController(
      emailController: _emailController,
      passwordController: _passwordController,
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
                  width: MediaQuery.of(context).size.width * 0.4,
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

              // Email
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
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),

                  // Email text field
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB5B5B5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _emailController,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter your e-mail',
                        hintStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: subtitleFontSize,
                          color: Colors.grey[800],
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Password
                  Padding(
                    padding: const EdgeInsets.only(left: 30, bottom: 5),
                    child: Text(
                      'Password',
                      style: TextStyle(
                        fontSize: subtitleFontSize,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xFFFFFFFF),
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),

                  // Password text field
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
                      obscureText: !_signInController.isPasswordVisible,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: subtitleFontSize,
                          color: Colors.grey[800],
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
                            _signInController.isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _signInController.isPasswordVisible =
                                  !_signInController.isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),

                  // Forgot password
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30, top: 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword()));
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: smallTextFontSize,
                            fontWeight: FontWeight.normal,
                            color: const Color(0xFFFFFFFF),
                            fontFamily: 'Montserrat',
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Sign in button
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Center(
                      child: SizedBox(
                        width: buttonSize,
                        child: ElevatedButton(
                          onPressed: () =>
                              _signInController.validateAndSignIn(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF725FAC),
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            minimumSize: const Size(double.infinity, 40),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text('Sign In',
                              style: TextStyle(fontSize: buttonFontSize)),
                        ),
                      ),
                    ),
                  ),

                  // Sign up button
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: Text(
                          'Don’t have an account? Sign Up Here',
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
