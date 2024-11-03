import 'package:flutter/material.dart';
// import '../util/SoundPart.dart';
import '../tab/sound_squares.dart';
// import 'view_plans.dart'; // Import the new_page_a.dart file
// import 'sleeping_stats.dart'; // Import the page_b.dart file
// import 'information.dart'; // Import the page_d.dart file
// import 'home_page.dart';
// import '../Navbar/bottom_navbar.dart'; // Import the BottomNavbar widget
// import '../Components/button_with_text.dart'; // Import the ButtonWithText widget
import '../Components/plus_button.dart'; // Import the PlusButton widget

class SoundPage extends StatelessWidget {
  const SoundPage({super.key});

//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Stack(
//             children: [
//               Column(
//                 children: [
//                   const Text(
//                   "Sounds",
//                   style: TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                   color:Color(0xFFA594F9),
//                     ),
//                   )
//                 ],
//               )
//             ],
//         )
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(children: [
                // Section 1: Hello You and Profile Icon
                Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                              'Sounds',
                              style: TextStyle(
                                fontSize: 24,
                                // Set the font size to 16
                                fontWeight: FontWeight.bold,
                                // Set the font weight to bold// Set the text color to white
                                fontFamily: 'Montserrat-Bold',
                              ),
                            ),
                          ),
                        ])),
                Column(
                  children: [Soundsquares()],
                )
              ])))
            ],
          ),

          // Add some space between sections
          // const SizedBox(height: 50),
          // Container(
          //   padding: const EdgeInsets.all(30),
          //   child: Column(
          //     children: [
          //       const Row(
          //
          //       )
          //     ],
          //   )
          // )

          Positioned(
            bottom: 56, // adjust this value as needed
            left: MediaQuery.of(context).size.width / 2 -
                30, // adjust the position as needed
            child: const PlusButton(),
          ),
        ],
      ),
    );
  }
}
