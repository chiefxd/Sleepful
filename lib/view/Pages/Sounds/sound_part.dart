import 'package:flutter/material.dart';

class SoundPart extends StatelessWidget {
  final String soundPictures;
  final String soundTitle;
  final String soundGenre;
  final String soundDuration;

  const SoundPart({
    super.key,
    required this.soundPictures,
    required this.soundTitle,
    required this.soundGenre,
    required this.soundDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(children: [
          //images
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Image.asset(soundPictures),
          ),
          //title
          Text(
            soundTitle,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 5),
          Text(soundGenre,
              style: TextStyle(
                  color: Colors.deepPurpleAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          const SizedBox(height: 12),
          Text(soundGenre,
              style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 10)),
          const SizedBox(height: 12),
          Text(soundDuration,
              style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 8)),
          //genre
          //duration
        ]),
      ),
    );
  }
}
