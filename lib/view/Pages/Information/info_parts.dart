import 'package:flutter/material.dart';

class InfoPart extends StatelessWidget {
  final String infoPictures;
  final String infoTitle;
  final String infoArticle;

  const InfoPart({
    super.key,
    required this.infoPictures,
    required this.infoTitle,
      required this.infoArticle,

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
            child: Image.asset(infoPictures),
          ),
          //title
          Text(
            infoTitle,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 5),
          Text(infoArticle,
              style: TextStyle(
                  color: Colors.deepPurpleAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
        ]),
      ),
    );
  }
}
