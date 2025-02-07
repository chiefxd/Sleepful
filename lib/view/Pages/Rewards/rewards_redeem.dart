import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sleepful/providers/rewards_provider.dart';
import 'package:sleepful/providers/user_data_provider.dart';
import 'package:sleepful/view/Pages/Rewards/rewards_page.dart';

class RewardsRedeem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String minutes;
  final int points;
  final int selectedIndex;
  final String soundId;

  const RewardsRedeem(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.minutes,
      required this.points,
      required this.soundId,
      this.selectedIndex = 2});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double subtitleFontSize =
        screenWidth * 0.04;
    double largeTextFontSize = screenWidth * 0.06;
    double smallTextFontSize = screenWidth * 0.035;
    double bottomText = screenWidth * 0.05;

    final userData = Provider.of<UserDataProvider>(context);

    // Check if user has enough points
    bool hasEnoughPoints = userData.points >= points;

    void showToast(String message) {
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Container(
                  height: screenHeight * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Title, Subtitle, and Paragraph
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: largeTextFontSize,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Text(
                            minutes,
                            style: TextStyle(
                              fontSize: smallTextFontSize,
                              fontFamily: 'Montserrat',
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 8.0),
                      Text(
                        'Your Subtitle Here',
                        style: TextStyle(
                          fontSize: subtitleFontSize,
                          fontFamily: 'Montserrat',
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'This is a paragraph text that provides more information about the reward that has been redeemed. You can add more details here to inform the user about the next steps or any other relevant information.',
                        style: TextStyle(
                          fontSize: smallTextFontSize,
                          fontFamily: 'Montserrat',
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(16.0),
                  margin: EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '$points PTS',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: bottomText,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      SizedBox(width: 24.0),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: hasEnoughPoints
                              ? () {
                                  final rewardsProvider =
                                      Provider.of<RewardsProvider>(context,
                                          listen: false);
                                  rewardsProvider.unlockSound(
                                      soundId);

                                  // Deduct points and navigate back
                                  userData.deductPoints(points);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RewardsPage()));

                                  showToast(
                                      "Successfully Redeemed!\nGo Check your Sound Page");
                                }
                              : null, // Disable button if not enough points
                          style: ElevatedButton.styleFrom(
                            backgroundColor: hasEnoughPoints
                                ? Theme.of(context).colorScheme.primary
                                : Color(
                                    0xFF5A5A5A),
                            disabledBackgroundColor: const Color(
                                0xFFAB9FD1),
                            disabledForegroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: hasEnoughPoints
                                  ? BorderRadius.circular(8.0)
                                  : BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            hasEnoughPoints ? 'Redeem' : 'Insufficient Points',
                            style: TextStyle(
                              color: hasEnoughPoints
                                  ? Theme.of(context).colorScheme.onSecondary
                                  : Colors.white,
                              fontSize: bottomText,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 27,
            left: 4,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const RewardsPage()));
                },
                child: Image.asset(
                  'assets/images/buttonBack.png',
                  width: 48,
                  height: 48,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
