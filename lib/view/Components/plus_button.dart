import 'package:flutter/material.dart';

// import '../Pages/Plans/add_plans.dart'; // import the SleepingStats page

class PlusButton extends StatelessWidget {
  final Widget targetPage; // Add a targetPage parameter

  const PlusButton({super.key, required this.targetPage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54, // Set the width of the button
      height: 54, // Set the height of the button
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context)
            .colorScheme
            .onTertiary, // Set the background color of the button
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
                MaterialPageRoute(builder: (context) => targetPage),
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
