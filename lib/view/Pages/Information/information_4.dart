import 'package:flutter/material.dart';

class InformationFour extends StatelessWidget {
  const InformationFour({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double refFontSize = screenWidth * 0.028;
    double textFontSize = screenWidth * 0.03;

    // return Scaffold(
    //   body: CustomScrollView(
    //     slivers: [
    //       SliverPadding(
    //         padding: const EdgeInsets.all(20.0),
    //         sliver: SliverToBoxAdapter( // Wrap the Column with SliverToBoxAdapter
    //           child: Column(
    //             children:
    //               // ... your existing content ...
    //             ],
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    //
    // )

    return Scaffold(
      body: SafeArea(
        child:
        NestedScrollView(
          headerSliverBuilder: (context, innerIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(); // Go back to the previous screen
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      'assets/images/buttonBack.png', // Use the same back button image
                      width: 48,
                      height: 48,
                    ),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: const Text(
                    'Information',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat', // Ensure the same font family is used
                      color: Color(0xFFB4A9D6), // Use the same color as in profile.dart
                    ),
                  ),
                ),
                centerTitle: false,
                floating: false,
                snap: false,
                pinned: false,
                forceElevated: innerIsScrolled,
              ),
            ];
          },
          body: CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                    padding: const EdgeInsets.all(20.0),
                    sliver: SliverToBoxAdapter(
                        child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset(
                                      "assets/images/info 4.jpg",
                                      width: 262,
                                      height: 205,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                              ),
                              const SizedBox(height: 5.0),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF1F1249),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Tidak bisa tidur meskipun dalam kondisi yang lelah merupakan hal yang cukup menyebalkan. Salah satu faktor yang membuat seseorang untuk kesulitan tidur adalah kertelambatan hormon melatonin untuk meninggikan produksinya. Hormon melatonin ini dipengaruhi oleh kondisi terang dan gelap dimana saat kondisi terang (siang hari), level produksi melatonin rendah, dan ketika gelap (malam hari) level produksinya akan meningkat. Jika level produksinya kurang, maka seseorang akan mengalami kesulitan untuk tidur.  ',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontSize: textFontSize,
                                        fontFamily: 'Montserrat',
                                        color:Color(0xFFE4DCFF),
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    Text(
                                      'Tidak hanya melatonin,tidur siang yang terlalu lama atau tidur siang secara terlambat dapat mempengaruhi DSPS. Tidur siang dianjurkan untuk dilakukan selama 20 hingga 30 menit, jika terlalu panjang maka akan menimbulkan kesulitan untuk tidur di malam hari. Selain durasi, waktu tidur siang yang sudah menunjukkan sore hari juga mempengaruhi kondisi ini.  ',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontSize: textFontSize,
                                        fontFamily: 'Montserrat',
                                        color:Color(0xFFE4DCFF),
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    Text(
                                      'Kondisi mental seperti, rasa cemas yang berlebihan dapat membuat pikiran berjalan secara terus menerus sehingga menimbulkan kehilangan ketenangan dan kenyamanan untuk tidur. Rasa depresi, ketakutan atau kesedihan yang cukup dalam juga dapat membuat pikiran terus berjalan sehingga membuat kesulitan untuk tidur. Faktor lain seperti kafein yang dapat membuat seseorang tetap terjaga dan terang dari gadget juga dapat menjadi penyebab kesulitan tidur.',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontSize: textFontSize,
                                        fontFamily: 'Montserrat',
                                        color:Color(0xFFE4DCFF),
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    Text(
                                      'Tidak hanya melatonin, tidur siang yang terlalu lama atau tidur siang secara terlambat dapat mempengaruhi DSPS. Tidur siang dianjurkan untuk dilakukan selama 20 hingga 30 menit, jika terlalu panjang maka akan menimbulkan kesulitan untuk tidur di malam hari. Selain durasi, waktu tidur siang yang sudah menunjukkan sore hari juga mempengaruhi kondisi ini.  ',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontSize: textFontSize,
                                        fontFamily: 'Montserrat',
                                        color:Color(0xFFE4DCFF),
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    Text(
                                      'Dikutip dari CDC, kesulitan tidur dan tidak bisa tidur yang berkepanjangan dapat mengakibatkan timbul potensi risiko penyakit seperti diabetes, penyakit jantung, obesitas, dan depresi. Untuk menjaga tubuh dapat tidur dengan baik dan mencegah terjadinya kondisi lelah tapi tidak bisa tidur, terdapat beberapa hal yang dapat dilakukan seperti: ',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontSize: textFontSize,
                                        fontFamily: 'Montserrat',
                                        color:Color(0xFFE4DCFF),
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    RichText(
                                      textAlign: TextAlign.justify,
                                      text: TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 5.0),
                                              child: Text(
                                                '•',
                                                style: TextStyle(
                                                  fontSize: textFontSize,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFFE4DCFF),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Membuat nyaman suhu kamar (19°C – 25°C)',
                                            style:TextStyle(
                                              fontSize: textFontSize,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFFE4DCFF),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    RichText(
                                      textAlign: TextAlign.justify,
                                      text: TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 5.0),
                                              child: Text(
                                                '•',
                                                style: TextStyle(
                                                  fontSize: textFontSize,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFFE4DCFF),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Mengatur pencahayaan gelap ketika tidur',
                                            style:TextStyle(
                                              fontSize: textFontSize,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFFE4DCFF),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    RichText(
                                      textAlign: TextAlign.justify,
                                      text: TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 5.0),
                                              child: Text(
                                                '•',
                                                style: TextStyle(
                                                  fontSize: textFontSize,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFFE4DCFF),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Tidak menggunakan gadget sebelum tidur ',
                                            style:TextStyle(
                                              fontSize: textFontSize,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFFE4DCFF),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    RichText(
                                      textAlign: TextAlign.justify,
                                      text: TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 5.0),
                                              child: Text(
                                                '•',
                                                style: TextStyle(
                                                  fontSize: textFontSize,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFFE4DCFF),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Membuat kamar kedap suara dengan baik ',
                                            style:TextStyle(
                                              fontSize: textFontSize,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFFE4DCFF),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    RichText(
                                      textAlign: TextAlign.justify,
                                      text: TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 5.0),
                                              child: Text(
                                                '•',
                                                style: TextStyle(
                                                  fontSize: textFontSize,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFFE4DCFF),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Relaksasi dengan membaca atau meditasi',
                                            style:TextStyle(
                                              fontSize: textFontSize,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFFE4DCFF),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    Text(
                                      'Referensi:\nwww.labcito.co.id',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontSize: refFontSize,
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFFE4DCFF),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ]
                        )
                    )
                ),
              ]
          ),
        ),
      ),
    );
  }
}
