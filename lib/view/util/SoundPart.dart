import 'package:flutter/material.dart';

class SoundPart extends StatelessWidget {
  final String Pictures;
  final String SoundTitle;
  final String SoundGenre;
  final String SoundDuration;

  const SoundPart({
    super.key,
    required this.Pictures,
    required this.SoundTitle,
    required this.SoundGenre,
    required this.SoundDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            //images
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child:
              Image.asset(Pictures),
            ),
            //title
            Text(
              SoundTitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
            const SizedBox(height:5),
            Text(
              SoundGenre,
              style: TextStyle(
                  color: Colors.deepPurpleAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              )
            ),
            const SizedBox(height:12),
            Text(
                SoundGenre,
                style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontSize: 10
                )
            ),
            const SizedBox(height:12),
            Text(
                SoundDuration,
                style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontSize: 8
                )
            ),
            //genre
            //duration

          ]

        ),
      ),
    );
  }
}