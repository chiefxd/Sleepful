import 'package:flutter/material.dart';
import '../Util/sound_part.dart';

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
              Pictures: SoundAvailable[index][0],
              SoundTitle: SoundAvailable[index][1],
              SoundGenre: SoundAvailable[index][2],
              SoundDuration: SoundAvailable[index][3]);
        });
  }
}