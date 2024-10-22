import 'package:flutter/material.dart';
import '../Pages/sleeping_stats.dart';  // import the SleepingStats page

class PlusButton extends StatelessWidget {
  const PlusButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SleepingStats()),
        );
      },
      child: const Icon(Icons.add, size: 30,),
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