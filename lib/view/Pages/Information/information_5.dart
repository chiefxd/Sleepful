import 'package:flutter/material.dart';

import 'information.dart';

class InformationFive extends StatelessWidget {
  const InformationFive({super.key});

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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const Information())); // Go back to the previous screen
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
                          "assets/images/info 5.jpg",
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
                          'Kesulitan tidur dapat menjadi salah satu gangguan tidur. Perlu diketahui bahwa seseorang biasanya membutuhkan waktu 15-20 menit untuk tertidur dan jika membutuhkan waktu lebih lama, hal ini dapat menunjukan adanya tanda siklus tidur yang tidak sehat. Untuk mendapatkan tidur yang cukup, yuk kita cari tahu cara agar cepat tertidur melalui poin-poin berikut: ',
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
                                    '1.',
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
                                text: 'Tidur pada Waktu yang Ditentukan',
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
                          'Untuk tertidur lebih cepat, cobalah untuk memiliki rutinitas tidur. Rutinitas tidur membutuhkan disiplin diri. Oleh karena itu, mulailah dengan menjadwalkan waktu yang sama untuk tidur dan bangun setiap hari. Dengan begitu, rutinitas tidur baru akan terbentuk dan tubuh pun akan otomatis mengikutinya. ',
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
                                    '2.',
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
                                text: 'Mandi dengan Air Hangat Sebelum Tidur',
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
                          'Salah satu cara agar cepat terlelap adalah mandi dengan air hangat. Air hangat dapat membuat tubuh lebih rileks sehingga lebih cepat mengantuk. Dengan demikian, mandi dengan air hangat secara tidak langsung akan membantu Anda lebih mudah terlelap. ',
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
                                    '3.',
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
                                text: 'Mendengarkan Musik ',
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
                          'Jika Anda sulit terlelap, cobalah untuk menutup pintu dan jendela agar terhindar dari suara bising. Kemudian, tenangkan diri dengan mendengarkan musik agar tubuh lebih rileks. Namun, pastikan untuk mendengarkan musik menggunakan speaker, bukan earphone karena hal tersebut memungkinkan adanya cedera dan infeksi telinga.  ',
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
                                    '4.',
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
                                text: 'Ciptakan Lingkungan yang Nyaman',
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
                          'Jika mendengarkan musik tidak cukup untuk memicu kantuk, cobalah ciptakan suasana yang hening, gelap, dan sejuk pada kamar. Untuk menghalau suara bising dari luar, kenakan penyumbat telinga dan matikan ponsel pintar agar Anda lebih cepat terlelap dan lingkungan pun hening. Setelah itu, tutup tirai untuk mencegah masuknya cahaya dari luar dan pastikan suhu ruangan juga tetap sejuk dan nyaman saat tidur. ',
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
                                    '5.',
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
                                text: ' Terapkan Pola Makan yang Tepat ',
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
                          'Kesulitan tidur juga bisa disebabkan oleh pola makan atau kebiasaan yang tidak sehat. Oleh karena itu, perlu diterapkan pola makan yang tepat agar tubuh rileks dan kualitas tidur menjadi lebih baik. Beberapa contoh pola makan yang tepat antara lain menghindari makan makanan berlemak tinggi dalam porsi besar dan menghindari minuman berkafein sebelum tidur. ',
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
                                    '6.',
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
                                text: ' Berolahraga Secara Teratur ',
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
                          'Olahraga secara teratur di pagi atau sore hari dapat membantu untuk tertidur cepat. Jenis olahraga yang dilakukan tidak harus selalu berat, tetapi bisa dengan olahraga ringan yang dapat disesuaikan dengan aktivitas harian. Seiring berjalannya waktu, Anda dapat meningkatkan intensitas olahraga. Jenis latihan yang dapat diterapkan antara lain Jogging, bersepeda, berenang, yoga, dan meditasi.  ',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: textFontSize,
                            fontFamily: 'Montserrat',
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        Text(
                          'Referensi:\nwww.siloamhospitals.com',
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
