import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  String appVersion = '';

  @override
  void initState() {
    super.initState();
    _getAppVersion();
  }

  Future<void> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
    });
  }

  Widget _buildIconRow(IconData icon, String text, double fontSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFFB4A9D6)),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              color: Color(0xFFB4A9D6),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double titleFontSize = screenWidth * 0.06;
    double subtitleFontSize = screenWidth * 0.04;
    double miniFontSize = screenWidth * 0.03;

    return Scaffold(
      // Section 1: Title and Back Button
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
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
            'About Us',
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              color: Color(0xFFB4A9D6),
            ),
          ),
        ),
      ),

      // Section 2: About Us Contents
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Image.asset(
                  'assets/images/Logo Sleepful.png',
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
              ),

              SizedBox(height: 15),

              // App Name
              Text(
                'Sleepful',
                style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: Color(0xFFB4A9D6)),
              ),

              SizedBox(height: 0),

              // Desc
              Text(
                'Helps you to sleep peacefully',
                style: TextStyle(
                    fontSize: subtitleFontSize,
                    fontFamily: 'Montserrat',
                    color: Color(0xFFB4A9D6)),
              ),

              SizedBox(height: 20),

              // Contact Us
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildIconRow(
                      Icons.headphones, 'Contact Us', subtitleFontSize),
                  Row(
                    children: [
                      SizedBox(width: 40),
                      Expanded(
                        child: Text(
                          '- Email: sleepful@gmail.com',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: miniFontSize,
                            fontFamily: 'Montserrat',
                            color: Color(0xFFB4A9D6),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 40),
                      Expanded(
                        child: Text(
                          '- Phone: 081368395466',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: miniFontSize,
                            fontFamily: 'Montserrat',
                            color: Color(0xFFB4A9D6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          // App Version
          Positioned(
            bottom: 10, // Adjust as needed
            left: 20, // Aligned with headphone icon
            child: Text(
              'App Version: $appVersion',
              style: TextStyle(
                fontSize: miniFontSize,
                fontFamily: 'Montserrat',
                color: Color(0xFFB4A9D6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
