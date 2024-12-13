import 'package:flutter/material.dart';

class InformationThree extends StatelessWidget {
  const InformationThree({super.key});

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
                    'Informations',
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
                          "assets/images/info 3.jpg",
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
                          'Belajar tidak selalu menyenangkan terutama setelah seharian melakukan kegiatan yang berat dan dimana otak  terasa ingin berhenti bekerja. Berikut adalah sembilan strategi yang dapat membantu anda untuk tetap fokus: ',
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
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: 'Bergerak',
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
                          'Gerakan merupakan pendorong energi yang dicatat dengan baik. Selain membantu untuk tetap terjaga, bergerak juga dapat meredakan stres dan membantu meningkatkan kemampuan memori untuk mengingat. Usahakanlah untuk beristirahat sejenak setiap 30 hingga 50 menit untuk berjalan, menari, atau bergerak yang dapat membantu tubuh untuk terjaga. ',
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
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: 'Terpapar Sinar Matahari',
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
                          'Tubuh kita terbiasa untuk merespons sinyal lingkungan seperti cahaya dan kegelapan. Meskipun hubungan antara cahaya dan tidur bersifat tidak langsung ,cahaya merupakan isyarat yang dapat membantu meningkatkan kewaspadaan. Sehingga, cobalah meniru lingkungan siang hari dengan pencahayaan yang cukup dan banyak.  ',
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
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: 'Duduk Tegak',
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
                          'Anda mungkin tergoda untuk merasa nyaman saat belajar, tetapi hal itu tidak akan membantu Anda tetap terjaga untuk belajar. Dengan duduk tegak, fungsi pada sistem saraf simpatik dapat berjalan sehingga memberikan kewaspadaan. Tidak hanya itu,berdiri dan bergerak dari waktu ke waktu dapat membantu meningkatkan sirkulasi darah yang dapat mencegah rasa ngantuk.  ',
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
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: 'Hindari Tempat Tidur',
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
                          'Tempat yang paling nyaman untuk belajar mungkin adalah tempat anda tidur. Namun, sebaiknya hindari tempat tidur dan jika memungkinkan, anda dapat belajar di tempat lain, seperti perpustakaan, kedai kopi, atau area khusus yang terang dan jauh dari kamar tidur Anda. Dengan memisahkan area belajar dan tidur, anda juga akan lebih mudah mematikan otak saat waktunya memejamkan mata. ',
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
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: 'Minum Banyak Air',
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
                          'Kelelahan atau ngantuk terkadang merupakan tanda dehidrasi. Dehidrasi tidak hanya akan menguras energi Anda tetapi juga dapat mengganggu fungsi kognitif, sehingga membuat belajar menjadi sulit. Untuk menghindari tertidur saat belajar, tetaplah terhidrasi sepanjang hari dengan mengusahakan untuk minum sekitar setengah galon per hari. ',
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
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: 'Makan yang Sehat',
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
                          'Meskipun ada rasa untuk ngemil saat belajar, hal tersebut tidak akan membantu untuk tetap terjaga.Sebaliknya, usahakan untuk makan dalam porsi kecil tetapi sering dan pastikan setiap makanan mengandung protein, karbohidrat kompleks, dan sumber lemak sehat.  ',
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
                                    '7.',
                                    style: TextStyle(
                                      fontSize: textFontSize,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: 'Menggunakan Teknik Belajar Aktif',
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
                          'Membaca dan membaca ulang catatan kelas atau buku teks mungkin tidak cukup untuk membuat Anda tetap terjaga, apalagi menyerap informasi. Agar dapat mendapatkan hasil yang maksimal, anda dapat menerapkan teknik belajar aktif seperti melakukan latihan dan menggunakan visual seperti diagram dan kartu petunjuk. ',
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
                                    '8.',
                                    style: TextStyle(
                                      fontSize: textFontSize,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: ' Belajar dengan Teman ',
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
                          'Belajar sosial tidak hanya lebih memotivasi tetapi juga dapat menawarkan perspektif dan interpretasi baru dari materi kelas. Anda dapat meminta bantuan kepada seseorang untuk menjelaskan konsep yang masih membingungkan, atau memperkuat pemahaman dengan mengajarkan materi kepada sesama teman. Jika lebih suka belajar sendiri, anda mungkin menemukan bahwa belajar di hadapan orang lain dapat menghindari ngantuk. ',
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
                                    '9.',
                                    style: TextStyle(
                                      fontSize: textFontSize,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: 'Dapatkan Tidur yang Berkualitas',
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
                          'Tidur memainkan peran penting sehingga dengan kekurangan tidur, kinerja akademis dapat memburuk. Faktanya, menjadikan tidur sebagai prioritas dapat menjadi cara paling efektif untuk tetap waspada saat belajar. Jika memungkinkan, luangkan waktu untuk tidur siang dan jalankan jadwal tidur yang teratur untuk membantu mempermudah belajar. ',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: textFontSize,
                            fontFamily: 'Montserrat',
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          'Referensi:\nwww.heathline.com',
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
