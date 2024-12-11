// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleepful/providers/rewards_provider.dart';
import 'package:sleepful/view/Pages/Sounds/sound_player.dart';

import '../../Pages/Sounds/sound_part.dart';

class SoundSquares extends StatelessWidget {
  const SoundSquares({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RewardsProvider>(
        builder: (context, rewardsProvider, child) {
      final unlockedSoundsData = rewardsProvider.unlockedSounds;

      // Combine default sounds and unlocked sounds
      List<dynamic> allSounds = [
        SoundPart(
          soundPictures: "assets/images/rain.jpg",
          soundTitle: "Rain",
          soundGenre: "Relaxing",
          soundDuration: "30m",
        ),
        SoundPart(
          soundPictures: "assets/images/night.jpg",
          soundTitle: "Night",
          soundGenre: "Calm, Soothing",
          soundDuration: "17m",
        ),
        SoundPart(
          soundPictures: "assets/images/mix.jpg",
          soundTitle: "Mix",
          soundGenre: "Relaxing",
          soundDuration: "36m",
        ),
        SoundPart(
          soundPictures: "assets/images/winter.jpg",
          soundTitle: "Winter",
          soundGenre: "Ambient",
          soundDuration: "15m",
        ),
        SoundPart(
          soundPictures: "assets/images/comfort.jpeg",
          soundTitle: "Comfort",
          soundGenre: "Calm, Ambient",
          soundDuration: "17m",
        ),
        ...unlockedSoundsData,
      ];

      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.55, // Adjust as needed
        ),
        itemCount: allSounds.length,
        itemBuilder: (context, index) {
          final item = allSounds[index];
          return _buildGridItem(context, index, item);
        },
      );
    });
  }

  Widget _buildGridItem(BuildContext context, int index, SoundPart item) {
    double screenWidth = MediaQuery.of(context).size.width;
    double titleFontSize = screenWidth * 0.055;
    double subtitleFontSize = screenWidth * 0.035;

    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SoundPlayer(soundTitle: item.soundTitle),
            ),
          );
        },
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      item.soundPictures,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(item.soundTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: titleFontSize,
                            fontFamily: 'Montserrat',
                            color: Color(0xFFAB9FD1),
                          )),
                    ),
                    Center(
                      child: Text(item.soundGenre,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: subtitleFontSize,
                            fontFamily: 'Montserrat',
                            color: Color(0xFF6A5B9A),
                          )),
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    Center(
                      child: Text(
                        item.soundDuration,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: subtitleFontSize,
                          fontFamily: 'Montserrat',
                          color: Color(0xFF6A5B9A),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

// @override
// Widget build(BuildContext context) {
//   return GridView.builder(
//       itemCount: SoundAvailable.length,
//       padding: EdgeInsets.all(10),
//       gridDelegate:
//       SliverGridDelegateWithFixedCrossAxisCount
//         (crossAxisCount: 2),
//       itemBuilder: (context, index) {
//         return SoundPart(
//             pictures: SoundAvailable[index].pictures,
//             soundTitle: SoundAvailable[index].soundTitle,
//             soundGenre: SoundAvailable[index].soundGenre,
//             soundDuration: SoundAvailable[index].soundDuration
//         );
//       },
//   );
// }
