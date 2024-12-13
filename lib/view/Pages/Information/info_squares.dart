import 'package:flutter/material.dart';
import 'package:sleepful/view/Pages/Information/information_1.dart';
import 'package:sleepful/view/Pages/Information/information_2.dart';
import 'package:sleepful/view/Pages/Information/information_3.dart';
import 'package:sleepful/view/Pages/Information/information_4.dart';
import 'package:sleepful/view/Pages/Information/information_5.dart';

import '../../Pages/Information/info_parts.dart';

class InfoSquares extends StatelessWidget {
  List<InfoPart> infoAvailable = [
    InfoPart(
      infoPictures: "assets/images/info 1.jpg",
      infoTitle: "Kesehatan Mental Dapat Terpengaruhi oleh Tidur?",
      infoArticle:
          "Kesehatan mental merupakan hal yang cukup penting bagi seseorang. Namun...",
    ),
    InfoPart(
      infoPictures: "assets/images/info 2.jpg",
      infoTitle:
          "Apakah Benar Kurang Tidur Mempengaruhi Penampilan? Ini Jawabannya!",
      infoArticle:
          "Sama halnya seperti makan dan minum, tidur juga merupakan...",
    ),
    InfoPart(
        infoPictures: "assets/images/info 3.jpg",
        infoTitle: "Begini Caranya Mencegah Tidur saat Belajar!",
        infoArticle:
            "Belajar tidak selalu menyenangkan terutama setelah seharian melakukan kegiatan yang berat..."),
    InfoPart(
        infoPictures: "assets/images/info 4.jpg",
        infoTitle: "Capek, tapi Tidak Bisa Tidur? Ini Alasannya!",
        infoArticle:
            "Tidak bisa tidur meskipun dalam kondisi yang lelah merupakan hal yang cukup menyebalkan..."),
    InfoPart(
        infoPictures: "assets/images/info 5.jpg",
        infoTitle: "Ini Beberapa Tips & Trik Agar Cepat Tidur!",
        infoArticle:
            "Kesulitan tidur dapat menjadi salah satu gangguan tidur yang berdampak buruk bagi..."),
  ];

  InfoSquares({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: infoAvailable.length,
      itemBuilder: (context, index) {
        final item = infoAvailable[index];
        return Column(
          // Wrap with Column to use AspectRatio
          children: [
            AspectRatio(
              aspectRatio: 2.274 / 1, // Set desired aspect ratio
              child: _buildCardItem(context, index, item),
            ),
            if (index < infoAvailable.length - 1) const SizedBox(height: 15.0),
          ],
        );
      },
    );
  }

  Widget _buildCardItem(BuildContext context, int index, InfoPart item) {
    double screenWidth = MediaQuery.of(context).size.width;
    double titleFontSize = screenWidth * 0.028;
    double subtitleFontSize = screenWidth * 0.02;

    return GestureDetector(
        onTap: () {
          // Navigation logic based on index
          if (index == 0) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => InformationOne()));
          } else if (index == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => InformationTwo()));
          } else if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => InformationThree()));
          } else if (index == 3) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        InformationFour())); // Add more conditions for other items as needed
          } else if (index == 4) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => InformationFive()));
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            // Wrapwith Container
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .onSecondary, // Set background color
              borderRadius: BorderRadius.circular(10), // Add rounded corners
            ),
            padding: const EdgeInsets.all(16.0), // Add padding
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    item.infoPictures,
                    width: 150,
                    height: 117,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Center align text vertically
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.infoTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: titleFontSize,
                            fontFamily: 'Montserrat',
                            color: Theme.of(context).colorScheme.primary,
                          )),
                      const SizedBox(height: 10.0),
                      Text(item.infoArticle,
                          style: TextStyle(
                            fontSize: subtitleFontSize,
                            fontFamily: 'Montserrat',
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
