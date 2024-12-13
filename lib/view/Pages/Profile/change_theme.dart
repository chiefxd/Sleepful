import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sleepful/providers/theme_provider.dart';
import 'package:sleepful/view/Pages/Profile/profile.dart';

import '../splash_screen.dart';

class ChangeTheme extends StatefulWidget {
  const ChangeTheme({super.key});

  @override
  State<ChangeTheme> createState() => _ChangeThemeState();
}

class _ChangeThemeState extends State<ChangeTheme> {
  int _selectedTheme = 0; // 0: Light, 1: Dark, 2: Auto

  @override
  void initState() {
    super.initState();
    // Initialization moved to didChangeDependencies
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Get the current theme from the provider
    final themeProvider = Provider.of<ThemeProvider>(context);

    setState(() {
      _selectedTheme = themeProvider.isAuto
          ? 2 // Auto mode
          : themeProvider.currentTheme == ThemeMode.light
              ? 0 // Light mode
              : 1; // Dark mode
    });
  }

  // Show Toast
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

  Widget _buildThemeOption(
      int index, String iconPath, String label, String description) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedTheme = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double screenWidth = constraints.maxWidth;

            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    iconPath,
                    width: double.infinity,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Radio<int>(
                      value: index,
                      groupValue: _selectedTheme,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedTheme = value!;
                        });
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: TextStyle(
                            fontSize:
                                screenWidth * 0.042, // Responsive font size
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize:
                                screenWidth * 0.03, // Responsive font size
                            fontFamily: 'Montserrat',
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double titleFontSize = screenWidth * 0.06;
    double buttonFontSize = screenWidth * 0.05;
    double buttonSize = screenWidth * 0.3;

    return Scaffold(
      // Section 1: Title and Back Button
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Profile()));
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
            'Change Theme',
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),

      // Section 2: Change Theme Contents
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 25),
                _buildThemeOption(
                  0,
                  'assets/images/Contoh 1.png',
                  'Light Mode',
                  'Provides a bright and vibrant interface',
                ),
                SizedBox(height: 15),
                _buildThemeOption(
                  1,
                  'assets/images/Contoh 1.png',
                  'Dark Mode',
                  'Provides a dark and comfortable interface',
                ),
                SizedBox(height: 15),
                _buildThemeOption(
                  2,
                  'assets/images/Contoh 1.png',
                  'Automatically',
                  'Switches automatically based on timezone',
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Center(
                    child: SizedBox(
                      width: buttonSize,
                      child: ElevatedButton(
                        onPressed: () {
                          ThemeMode newTheme;
                          bool isAuto = false;

                          switch (_selectedTheme) {
                            case 0:
                              newTheme = ThemeMode.light;
                              break;
                            case 1:
                              newTheme = ThemeMode.dark;
                              break;
                            case 2:
                              newTheme = ThemeMode
                                  .dark; // Default to dark, overridden by auto logic
                              isAuto = true; // Set auto mode
                              break;
                            default:
                              newTheme = ThemeMode.dark;
                          }

                          final themeProvider = Provider.of<ThemeProvider>(
                              context,
                              listen: false);
                          themeProvider.setTheme(newTheme, isAuto: isAuto);

                          showToast('Theme updated successfully!');

                          // Redirect to splash screen
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SplashScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.error,
                          foregroundColor: Colors.white,
                          textStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: buttonFontSize,
                          ),
                          minimumSize: const Size(double.infinity, 40),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Save',
                          style: TextStyle(fontSize: buttonFontSize),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
