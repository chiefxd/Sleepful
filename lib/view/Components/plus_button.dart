import 'package:flutter/material.dart';
import '../Pages/sleeping_stats.dart';  // import the SleepingStats page

class PlusButton extends StatelessWidget {
  const PlusButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54, // Set the width of the button
      height: 54, // Set the height of the button
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF725FAC), // Set the background color of the button
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            spreadRadius: 2,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ClipOval(
        child: Material(
          color: Colors.transparent, // Set the background color to transparent
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SleepingStats()),
              );
            },
            child: const Center(
              child: Icon(
                Icons.add,
                size: 50,
                color: Colors.white, // Set the icon color
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class PlusButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FloatingActionButton(
//       onPressed: () {  },
//       child: const Icon(Icons.add, size: 30,),
//     );
//   }
// }