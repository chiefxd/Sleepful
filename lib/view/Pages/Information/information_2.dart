import 'package:flutter/material.dart';

class InformationTwo extends StatelessWidget {
  const InformationTwo({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
        child: NestedScrollView(
          headerSliverBuilder: (context, innerIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pop(); // Go back to the previous screen
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
                  child: Text(
                    'Information',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily:
                          'Montserrat', // Ensure the same font family is used
                      color: Theme.of(context)
                          .colorScheme
                          .primary, // Use the same color as in profile.dart
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
          body: CustomScrollView(slivers: <Widget>[
            SliverPadding(
                padding: const EdgeInsets.all(20.0),
                sliver: SliverToBoxAdapter(
                    child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          "assets/images/info 2.jpg",
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
                          'Sama halnya seperti makan dan minum, tidur juga merupakan kebutuhan pokok yang dibutuhkan oleh seorang manusia. Oleh karena itu,  kekurangan tidur yang berlebihan dapat mengakibatkan berbagai macam efek negatif, seperti pada penampilan. Efek pada penampilan yang dapat terjadi akibat kurangnya tidur antara lain: ',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: textFontSize,
                            fontFamily: 'Montserrat',
                            color: Color(0xFFE4DCFF),
                          ),
                        ),
                        const SizedBox(height: 25.0),
                        RichText(
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
                                text: 'Wajah Terlihat Lebih Tua',
                                style: TextStyle(
                                  fontSize: textFontSize,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFFE4DCFF),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          'Tidur dapat membentuk kolagen yang membuat elastisitas terjaga. Jika seseorang mengalami kekurangan tidur, produksi kolagen akan menurun sehingga kebutuhan tubuh, terutama kulit, tidak dapat tercukupi dan kerutan dapat muncul lebih cepat.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: textFontSize,
                            fontFamily: 'Montserrat',
                            color: Color(0xFFE4DCFF),
                          ),
                        ),
                        const SizedBox(height: 25.0),
                        RichText(
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
                                text: 'Mengurangi Kelembapan Kulit',
                                style: TextStyle(
                                  fontSize: textFontSize,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFFE4DCFF),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          'Kulit dapat terpapar polusi dan sinar matahari setelah seharian beraktivitas. Ketika seseorang kurang tidur, elastisitas kulit perlahan akan menurun dan gampang untuk terjadi keriput pada kulit. Dengan adanya tidur yang cukup, kelmbapan kulit dapat terjaga sehigga ternutrisi dan terhindar dari keriput. ',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: textFontSize,
                            fontFamily: 'Montserrat',
                            color: Color(0xFFE4DCFF),
                          ),
                        ),
                        const SizedBox(height: 25.0),
                        RichText(
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
                                text: 'Masalah Jerawat Timbul',
                                style: TextStyle(
                                  fontSize: textFontSize,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFFE4DCFF),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          'Kurang tidur akan membuat tubuh menjadi terasa lebih lelah dari biasanya. Oleh karena itu, tubuh dapat memicu pengeluaran hormon stres yang dapat meningkatkan produksi minyak. Peningkatan tersebut dapat mengakibatkan sejumlah masalah kesehatan kulit dapat muncul, seperti jerawat. ',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: textFontSize,
                            fontFamily: 'Montserrat',
                            color: Color(0xFFE4DCFF),
                          ),
                        ),
                        const SizedBox(height: 25.0),
                        RichText(
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
                                text: 'Kulit Terlihat Kusam',
                                style: TextStyle(
                                  fontSize: textFontSize,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFFE4DCFF),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          'Selain terlihat selalu lelah, kulit akan menjadi lebih kusam karena kurang tidur. Kurang tidur tidak hanya melemahkan sistem kekebalan tubuh saja, tapi juga menurunkan produksi kolagen yang dapat membuat wajah jadi tampak kusam. ',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: textFontSize,
                            fontFamily: 'Montserrat',
                            color: Color(0xFFE4DCFF),
                          ),
                        ),
                        const SizedBox(height: 25.0),
                        RichText(
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
                                text: 'Munculnya Kantung Mata',
                                style: TextStyle(
                                  fontSize: textFontSize,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFFE4DCFF),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          'Pembuluh darah dan lapisan lemak pada bagian bawah mata hanya mempunyai sedikit lapisan lemak. Tak hanya itu, kolagen yang ada di lapisan kulit ini juga sangat halus dan tipis. Kekurangan tidur dapat mengakibatkan pembuluh darah di area tersebut melebar dan membuat mata menjadi menghitam.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: textFontSize,
                            fontFamily: 'Montserrat',
                            color: Color(0xFFE4DCFF),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          'Referensi:\nwww.halodoc.com',
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
                ]))),
          ]),
        ),
      ),
    );
  }
}
