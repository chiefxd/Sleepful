import 'package:flutter/material.dart';
import '../Pages/Sounds/sound_part.dart';

class SoundSquares extends StatelessWidget {
  List SoundAvailable = [
    ["assets/images/Contoh 1.png", "Sound 1", "Calm, Relaxing" "1h"],
    ["assets/images/Contoh 2.png", "Sound 2", "Magical" "55m"]
  ];

  SoundSquares({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: SoundAvailable.length,
        padding: EdgeInsets.all(10),
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return SoundPart(
              soundPictures: SoundAvailable[index][0],
              soundTitle: SoundAvailable[index][1],
              soundGenre: SoundAvailable[index][2],
              soundDuration: SoundAvailable[index][3]);
        });
  }
}
