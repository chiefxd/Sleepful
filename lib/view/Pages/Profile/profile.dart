import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  // Widget _buildIconRow(IconData icon, String text, double fontSize) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
  //     child: Row(
  //       children: [
  //         Icon(icon, color: Color(0xFFB4A9D6)),
  //         SizedBox(width: 10),
  //         Text(
  //           text,
  //           style: TextStyle(
  //             fontWeight: FontWeight.bold,
  //             fontFamily: 'Montserrat',
  //             color: Color(0xFFB4A9D6),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildIconRow(IconData icon, String text, double fontSize,
      {required BuildContext context, required String routeName}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Padding(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double titleFontSize = screenWidth * 0.06;
    double subtitleFontSize = screenWidth * 0.04;

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
            'Edit Profile',
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              color: Color(0xFFB4A9D6),
            ),
          ),
        ),
      ),

        // Section 2: Profile Contents
        body: Stack(
          children: [
            Column(
              children: <Widget>[
                SizedBox(height: 25),

                // Profile Pic
                CircleAvatar(
                  radius: 75,
                  backgroundImage: AssetImage('assets/images/Contoh 1.png'),
                ),

                SizedBox(height: 15),

                // User's Name
                Text(
                  'Stefan Santoso',
                  style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: Color(0xFFB4A9D6)),
                ),

                SizedBox(height: 0),

                // Sleep Time
                Text(
                  'Your total sleep time is 32 hours!',
                  style: TextStyle(
                      fontSize: subtitleFontSize,
                      fontFamily: 'Montserrat',
                      color: Color(0xFFB4A9D6)),
                ),

                SizedBox(height: 20),

                // 5 rows
                Column(
                  children: [
                    _buildIconRow(Icons.edit, 'Edit Profile', subtitleFontSize,
                        context: context,
                        routeName:
                            '/editProfile'),
                    _buildIconRow(
                        Icons.lock, 'Change Password', subtitleFontSize,
                        context: context,
                        routeName:
                            '/change_password'),
                    _buildIconRow(
                        Icons.palette, 'Change Theme', subtitleFontSize,
                        context: context,
                        routeName:
                            '/change_theme'),
                    _buildIconRow(Icons.info, 'About Us', subtitleFontSize,
                        context: context,
                        routeName:
                            '/about_us'),
                    _buildIconRow(Icons.logout, 'Log Out', subtitleFontSize,
                        context: context,
                        routeName:
                            '/logout'),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
  }
}
