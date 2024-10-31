import 'package:flutter/material.dart';
import 'package:sleepful/view/Pages/signin_page.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kok gini'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios), // Different icon for back button
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
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
                    return const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [0, 0.28, 1],
                      colors: [
                        Color(0xFFB4A9D6),
                        Color(0xFFB4A9D6),
                        Color(0xFFB4A9D6), //B4A9D6
                      ],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcIn, //
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
                  return const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0, 0.28, 1],
                    colors: [
                      Color(0xFFB4A9D6),
                      Color(0xFFB4A9D6),
                      Color(0xFFB4A9D6), //B4A9D6
                    ],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn, //
                child: const Text(
                  'to reset your password',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Email input field with label
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align label to the start
                children: [
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align label to the start
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 30, bottom: 5), // Adjust padding as needed
                        child: Text(
                          'E-mail',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFFFFFFFF),
                              fontFamily: 'Montserrat'),
                        ),
                      ),

                      // Password input field
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 3),
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                          color: Color(0xFFB5B5B5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter your e-mail',
                            hintStyle: TextStyle(fontFamily: 'Montserrat'),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                      height: 10), // Add spacing between input fields

                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Center(
                      child: SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignIn()),
                            );
                          },
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
    );
  }
}
