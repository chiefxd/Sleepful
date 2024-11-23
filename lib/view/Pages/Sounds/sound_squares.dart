// import 'dart:ui';

import 'package:flutter/material.dart';
import '../../Pages/Sounds/sounds_lofi.dart';
import '../../Pages/Sounds/sounds_winter.dart';
import '../../Pages/Sounds/sound_part.dart';
import '../../Pages/Sounds/sounds_sad.dart';
import '../../Pages/Sounds/sounds_night.dart';
import '../../Pages/Sounds/sounds_mix.dart';

class SoundSquares extends StatelessWidget {
  List<SoundPart> soundAvailable = [
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
      soundDuration: "28m",
    ),
    SoundPart(
      soundPictures: "assets/images/mix.jpg",
      soundTitle: "Mix",
      soundGenre: "Relaxing",
      soundDuration: "42m",
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
  ];

  SoundSquares({super.key});

  @override
  Widget build(BuildContext context) {

    // double screenWidth = MediaQuery.of(context).size.width;
    // double titleFontSize = screenWidth * 0.055;
    // double subtitleFontSize = screenWidth * 0.035;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.55, // Adjust as needed
      ),
      itemCount: soundAvailable.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final item = soundAvailable[index];
        return _buildGridItem(context, index, item);
      },
    );
  }


  Widget _buildGridItem(BuildContext context, int index, SoundPart item) {
    double screenWidth = MediaQuery.of(context).size.width;
    double titleFontSize = screenWidth * 0.055;
    double subtitleFontSize = screenWidth * 0.035;

    return GestureDetector(
        onTap: () {
      // Navigation logic based on index
      if (index == 0) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SoundsRain()));
      } else if (index == 1) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SoundsNight()));
      } else if (index == 2) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SoundsMix()));
      } else if (index == 3) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SoundsWinter())); // Add more conditions for other items as needed
      }else if (index == 4) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SoundsComfort()));
      }
    },
        child:  Card(
        color: Colors.transparent,
          elevation: 0,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child:AspectRatio(aspectRatio: 1.0,
                  child:ClipRRect(
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
                      child:Text(
                          item.soundTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: titleFontSize,
                            fontFamily: 'Montserrat',
                            color: Color(0xFFAB9FD1),
                          )
                      ),
                    ),

                    Center(
                      child:Text(
                          item.soundGenre,
                          style:TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: subtitleFontSize,
                            fontFamily: 'Montserrat',
                            color: Color(0xFF6A5B9A),
                          )
                      ),
                    ),
                    const SizedBox(height: 3.0,),

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
        )
    );
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


