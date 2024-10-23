import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
              child: Column(
            children: [
              Image.asset(
                'assets/images/Logo Sleepful.png',
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width * 0.4,
              ),
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0, 0.28, 1],
                    colors: [
                      Color(0xFF6048A6),
                      Color(0xFF8F7FC2),
                      Color(0xFFB4A9D6), //B4A9D6
                    ],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn, //
                child: const Text(
                  'Welcome to Sleepful!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight
                        .bold,
                    fontFamily: 'Montserrat',
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
                      Color(0xFF6048A6),
                      Color(0xFF8F7FC2),
                      Color(0xFFB4A9D6), //B4A9D6
                    ],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn, //
                child: const Text(
                  'Get ready to sleep peacefully',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
