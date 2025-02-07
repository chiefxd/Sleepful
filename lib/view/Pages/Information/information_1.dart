import 'package:flutter/material.dart';

import 'information.dart';

class InformationOne extends StatelessWidget {
  const InformationOne({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double refFontSize = screenWidth * 0.028;
    double textFontSize = screenWidth * 0.03;


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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const Information()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      'assets/images/buttonBack.png',
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
                          'Montserrat',
                      color: Theme.of(context)
                          .colorScheme
                          .primary,
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
                          "assets/images/info 1.jpg",
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
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kesehatan mental merupakan hal yang cukup penting bagi seseorang. Namun, kesehatan tersebut dapat dipengaruhi oleh faktor-faktor seperti kekurangan tidur . Beberapa dampak negatif yang dapat terjadi kepada kesehatan mental akibat kurangnya tidur antara lain: ',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: textFontSize,
                            fontFamily: 'Montserrat',
                            color: Theme.of(context).colorScheme.primary,
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
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: 'Gangguan Kecemasan',
                                style: TextStyle(
                                  fontSize: textFontSize,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          'Kekurangan tidur dapat memengaruhi seseorang untuk mengendalikan emosi. Akibatnya, seseorang dapat mengalami efek buruk seperti mimpi buruk dan serangan panik yang dapat terpicu akibat kurangnya tidur.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: textFontSize,
                            fontFamily: 'Montserrat',
                            color: Theme.of(context).colorScheme.primary,
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
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: 'Pengaruh pada Emosi',
                                style: TextStyle(
                                  fontSize: textFontSize,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          'Bagian otak yang dinamakan amygdala akan mengalami penurunan aktivitas hingga 60 persen jika mengalami kekurangan tidur. Bagian otak ini memengaruhi kemampuan otak untuk mengendalikan emosi, sehingga jika seseorang mengalami kekurangan tidur, '
                          'amygdala akan menjadi kurang aktif sehingga emosi akan semakin sulit untuk dikendalikan.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: textFontSize,
                            fontFamily: 'Montserrat',
                            color: Theme.of(context).colorScheme.primary,
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
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: 'Depresi',
                                style: TextStyle(
                                  fontSize: textFontSize,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          'Kondisi ini bisa diakibatkan karena kurang tidur dan semakin parah jika kekurangan tidur menjadi sebuah kebiasaan yang dilakukan sehari-hari.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: textFontSize,
                            fontFamily: 'Montserrat',
                            color: Theme.of(context).colorScheme.primary,
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
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: 'Gangguan Bipolar',
                                style: TextStyle(
                                  fontSize: textFontSize,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          'Kekurangan tidur dapat memperburuk episode mania yang dialami pengidap bipolar. Tidak hanya itu, kelelahan ekstrim dapat dipicu sehingga membuat durasi tidur menjadi lebih panjang saat fase depresi berlangsung. ',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: textFontSize,
                            fontFamily: 'Montserrat',
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          'Referensi:\nwww.halodoc.com',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: refFontSize,
                            fontFamily: 'Montserrat',
                            color: Theme.of(context).colorScheme.primary,
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
