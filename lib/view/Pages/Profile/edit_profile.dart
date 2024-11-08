import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  Widget _buildEditableIconRow(IconData icon, String text, double fontSize,
      TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {},
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
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Enter $text',
              hintStyle: TextStyle(
                fontSize: 12,
              ),
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

    return Scaffold(
      // Section 1: Title and Back Button
      body: NestedScrollView(
        headerSliverBuilder: (context, innerIsScrolled) {
          return [
            SliverAppBar(
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
              centerTitle: false,
              floating: true,
              snap: true,
              pinned: false,
            ),
          ];
        },

        // Section 2: Edit Profile Contents
        body: Stack(
          children: [
            SingleChildScrollView(
              // Wrap with SingleChildScrollView
              child: Column(
                children: <Widget>[
                  SizedBox(height: 25),

                  // Profile Pic
                  CircleAvatar(
                    radius: 75,
                    backgroundImage: AssetImage('assets/images/Contoh 1.png'),
                  ),

                  SizedBox(height: 15),

                  // Change Picture Hint
                  Text(
                    'Change Profile Picutre',
                    style: TextStyle(
                      fontSize: subtitleFontSize,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: Color(0xFFB4A9D6),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Name and E-mail Text Field
                  Column(
                    children: [
                      _buildEditableIconRow(
                        Icons.person,
                        'Name',
                        subtitleFontSize,
                        TextEditingController(),
                      ),
                      _buildEditableIconRow(
                        Icons.mail,
                        'E-mail Address',
                        subtitleFontSize,
                        TextEditingController(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
